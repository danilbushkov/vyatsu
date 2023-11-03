use eframe::egui;

use crate::defines::TASK_TEXT;
use crate::waiter::Waiter;
use eframe::egui::Ui;
use eframe::egui::{Context, Pos2, Vec2};
use egui::style::Margin;
use std::sync::atomic::{AtomicUsize, Ordering};
use std::sync::Arc;
use std::thread::JoinHandle;
use std::{thread, time};

use crate::fork::Fork;
use crate::philosopher::{Philosopher, State};

pub struct App {
    threads: Vec<JoinHandle<()>>,
    exit: Arc<AtomicUsize>,
    task_window_open: bool,
    philosophers: Vec<Arc<Philosopher>>,
    forks: Vec<Arc<Fork>>,
    waiter: Arc<Waiter>,
}

impl Drop for App {
    fn drop(&mut self) {
        self.exit.store(1, Ordering::SeqCst);
        for thread in self.threads.drain(..) {
            thread.join().unwrap();
        }
    }
}

impl eframe::App for App {
    fn update(&mut self, ctx: &egui::Context, _frame: &mut eframe::Frame) {
        ctx.request_repaint();
        if self.task_window_open {
            egui::Window::new("Задание")
                .open(&mut self.task_window_open)
                .show(ctx, |ui| {
                    ui.label(TASK_TEXT);
                });
        }
        egui::SidePanel::right("right")
            .resizable(false)
            .show(ctx, |ui| {
                for i in 0..self.philosophers.len() {
                    let ph = &mut self.philosophers[i];
                    ui.label("Частота философа ".to_owned() + &i.to_string() + " :");
                    let mut f = ph.get_mut_frequency();
                    ui.add(egui::Slider::new(&mut *f, 0..=100));
                }
                if ui.add(egui::Button::new("Показать задание")).clicked() {
                    self.task_window_open = true;
                }
                if ui.add(egui::Button::new("Сбросить")).clicked() {
                    let _guards: Vec<_> =
                        self.philosophers.iter().map(|ph| ph.get_guard()).collect();
                    for ph in self.philosophers.iter() {
                        ph.reset();
                    }
                    for fk in self.forks.iter() {
                        fk.visible(true)
                    }
                    self.waiter.reset();
                }
            });

        egui::CentralPanel::default().show(ctx, |_| {
            self.show_food(ctx, egui::pos2(200.0, 200.0));
            for i in 0..self.forks.len() {
                let fk = &self.forks[i];
                self.show_fork(ctx, &i.to_string(), fk.get_pos(), fk.is_visible());
            }
            for i in 0..self.philosophers.len() {
                let ph = &self.philosophers[i];
                self.show_philosopher(
                    ctx,
                    &i.to_string(),
                    ph.get_pos(),
                    ph.get_state(),
                    ph.get_left_fork(),
                    ph.get_right_fork(),
                    ph.get_number_of_eaten_portions(),
                );
            }
        });
    }
}

impl App {
    pub fn new() -> Self {
        let ph_pos2 = [
            egui::pos2(230.0, 20.0),
            egui::pos2(420.0, 120.0),
            egui::pos2(420.0, 350.0),
            egui::pos2(20.0, 350.0),
            egui::pos2(20.0, 120.0),
        ];
        let fork_pos2 = [
            egui::pos2(230.0, 140.0),
            egui::pos2(360.0, 140.0),
            egui::pos2(390.0, 230.0),
            egui::pos2(290.0, 320.0),
            egui::pos2(190.0, 230.0),
        ];
        let mut phs = vec![];
        let mut forks = vec![];
        let mut waiter_forks = vec![];
        for i in 0..5 {
            phs.push(Arc::new(Philosopher::new(i, ph_pos2[i])));
            let fork = Arc::new(Fork::new(fork_pos2[i], true));
            waiter_forks.push(Some(Arc::clone(&fork)));
            forks.push(fork);
        }

        let mut slf = Self {
            waiter: Arc::new(Waiter::new(phs.len(), waiter_forks)),
            exit: Arc::new(AtomicUsize::new(0)),
            threads: vec![],
            task_window_open: false,
            philosophers: phs,
            forks,
        };
        for i in 0..slf.philosophers.len() {
            slf.threads.push(Self::spawn_philosopher(
                &slf.philosophers[i],
                &slf.waiter,
                &slf.exit,
            ));
        }

        slf
    }

    fn spawn_philosopher(
        philosopher: &Arc<Philosopher>,
        waiter: &Arc<Waiter>,
        exit: &Arc<AtomicUsize>,
    ) -> JoinHandle<()> {
        let exit = Arc::clone(exit);
        let philosopher = Arc::clone(philosopher);
        let waiter = Arc::clone(waiter);
        thread::spawn(move || {
            while exit.load(Ordering::SeqCst) != 1 {
                let _guard = philosopher.get_guard();
                let frequency = philosopher.get_frequency();
                if frequency != 0 {
                    let ms = 1000 + (4000 - 200) / 100 * (101 - frequency);
                    thread::sleep(time::Duration::from_millis(ms as u64));
                    philosopher.set_state(State::Hungry);
                    let n = philosopher.get_name();
                    // let fs = vec![n, (n + 1) % 5];
                    let forks = waiter.take_forks(n);

                    for (_, f) in forks.iter() {
                        f.visible(false);
                    }
                    philosopher.set_right_fork(true);
                    philosopher.set_left_fork(true);

                    philosopher.set_state(State::Eat);
                    thread::sleep(time::Duration::from_millis(2000));

                    for (_, f) in forks.iter() {
                        f.visible(true);
                    }

                    philosopher.set_left_fork(false);
                    philosopher.set_right_fork(false);

                    waiter.put_forks(n, forks);

                    philosopher.inc_number_of_eaten_portions();
                    philosopher.set_state(State::Sleep);
                }
            }
        })
    }

    fn show_state_image(&self, ui: &mut Ui, state: State) {
        let image = match state {
            State::Eat => egui::include_image!("../images/eat.png"),
            State::Hungry => egui::include_image!("../images/hungry.png"),
            State::Sleep => egui::include_image!("../images/sleep.png"),
        };
        ui.add(
            egui::Image::new(image)
                .fit_to_exact_size(Vec2 { x: 100.0, y: 100.0 })
                .rounding(5.0),
        );
    }
    fn show_fork_image(&self, ui: &mut Ui, visible: bool) {
        egui::Frame::none()
            .inner_margin(Margin {
                left: 0.0,
                right: 0.0,
                top: 20.0,
                bottom: 20.0,
            })
            .show(ui, |ui| {
                if visible {
                    ui.add(
                        egui::Image::new(egui::include_image!("../images/fork.png"))
                            .fit_to_exact_size(Vec2 { x: 40.0, y: 60.0 })
                            .rounding(5.0),
                    );
                }
            });
    }
    fn show_fork(&self, ctx: &Context, name: &str, pos: Pos2, visible: bool) {
        egui::Area::new("fk".to_owned() + name)
            .fixed_pos(pos)
            .show(ctx, |ui| self.show_fork_image(ui, visible));
    }

    fn show_food(&self, ctx: &Context, pos: Pos2) {
        egui::Area::new("food").fixed_pos(pos).show(ctx, |ui| {
            ui.add(
                egui::Image::new(egui::include_image!("../images/food.png"))
                    .fit_to_exact_size(Vec2 { x: 200.0, y: 200.0 })
                    .rounding(5.0),
            );
        });
    }
    fn show_philosopher(
        &self,
        ctx: &Context,
        name: &str,
        pos: Pos2,
        state: State,
        left_fork: bool,
        right_fork: bool,
        number_of_eaten_portions: usize,
    ) {
        egui::Area::new("ph".to_owned() + name)
            .fixed_pos(pos)
            .show(ctx, |ui| {
                egui::Grid::new("vgrid".to_owned() + name).show(ui, |ui| {
                    egui::Frame::none()
                        .inner_margin(Margin {
                            left: 38.0,
                            right: 38.0,
                            top: 0.0,
                            bottom: 0.0,
                        })
                        .show(ui, |ui| {
                            ui.label("Философ ".to_owned() + name);
                        });
                    ui.end_row();
                    egui::Grid::new("grid".to_owned() + name)
                        .min_col_width(15.0)
                        .show(ui, |ui| {
                            self.show_fork_image(ui, left_fork);

                            self.show_state_image(ui, state);
                            self.show_fork_image(ui, right_fork);
                        });
                    ui.end_row();
                    ui.label(
                        "\tКоличество съеденных \n\t\t\t\t порций: ".to_owned()
                            + &number_of_eaten_portions.to_string(),
                    )
                });
            });
    }
}
