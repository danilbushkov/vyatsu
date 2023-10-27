use eframe::egui;

use rand::Rng;

use crate::defines::{TABLE_ROW_SIZE, USER_ARRAY};
use crate::shared_container::SharedContainer;
use std::collections::HashSet;
use std::sync::atomic::{AtomicUsize, Ordering};
use std::sync::Arc;
use std::thread;
use std::thread::JoinHandle;
use std::time;

pub struct App {
    adder_frequency: i32,
    reviewer_frequency: i32,
    shared_adder_frequency: Arc<SharedContainer<i32>>,
    shared_reviewer_frequency: Arc<SharedContainer<i32>>,
    task_window_open: bool,
    threads: Vec<JoinHandle<()>>,
    exit: Arc<AtomicUsize>,
    reset: Arc<AtomicUsize>,
    names: Arc<SharedContainer<Vec<&'static str>>>,
    set_of_added_names: Arc<SharedContainer<HashSet<&'static str>>>,
    added_names: Arc<SharedContainer<Vec<&'static str>>>,
    adder_position: Arc<SharedContainer<Option<usize>>>,
    reviewer_position: Arc<SharedContainer<Option<usize>>>,
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
        let reviwer = self.shared_reviewer_frequency.get_mut();
        let adder = self.shared_adder_frequency.get_mut();
        *reviwer = self.reviewer_frequency;
        *adder = self.adder_frequency;
        self.shared_adder_frequency.unlock();
        self.shared_reviewer_frequency.unlock();
        if self.task_window_open {
            egui::Window::new("Задание")
                .open(&mut self.task_window_open)
                .show(ctx, |ui| {
                    ui.label(crate::defines::TASK_TEXT);
                });
        }
        egui::SidePanel::right("right")
            .resizable(false)
            .show(ctx, |ui| {
                ui.label("Частота добавляющего:");
                ui.add(egui::Slider::new(&mut self.adder_frequency, 0..=100));
                ui.label("Частота проверяющего:");
                ui.add(egui::Slider::new(&mut self.reviewer_frequency, 0..=100));
                if ui.add(egui::Button::new("Показать задание")).clicked() {
                    self.task_window_open = true;
                }
                if ui.add(egui::Button::new("Сбросить")).clicked() {
                    self.reset.store(1, Ordering::SeqCst);
                    self.shared_reviewer_frequency.unlock();
                    self.adder_frequency = 0;
                    self.reviewer_frequency = 0;
                }
            });

        egui::CentralPanel::default().show(ctx, |ui| {
            //ui.with_layout(
            //    egui::Layout::top_down_justified(egui::Align::Center),
            //    |ui| {
            //    ui.label("world!");
            //    ui.label("Hello");
            egui::SidePanel::left("table0")
                .resizable(false)
                .show(ctx, |ui| {
                    self.user_table(ui, "table0", "Имена пользователей");
                });

            egui::SidePanel::right("table1")
                .resizable(false)
                .show(ctx, |ui| {
                    self.table_of_added_users(ui, "table1", "Имена уже добавленных пользователей");
                });
        });
    }
}

impl App {
    pub fn new() -> Self {
        let mut names = vec![];
        for _ in 0..TABLE_ROW_SIZE {
            names.push("");
        }
        let mut slf = Self {
            adder_frequency: 0,
            reviewer_frequency: 0,
            task_window_open: false,
            exit: Arc::new(AtomicUsize::new(0)),
            threads: vec![],
            names: Arc::new(SharedContainer::new(names)),
            adder_position: Arc::new(SharedContainer::new(None)),
            reviewer_position: Arc::new(SharedContainer::new(None)),
            set_of_added_names: Arc::new(SharedContainer::new(HashSet::new())),
            added_names: Arc::new(SharedContainer::new(vec![])),
            shared_adder_frequency: Arc::new(SharedContainer::new(0)),
            shared_reviewer_frequency: Arc::new(SharedContainer::new(0)),
            reset: Arc::new(AtomicUsize::new(0)),
        };
        slf.threads.push(slf.spawn_adder());
        slf
    }
    fn spawn_adder(&self) -> JoinHandle<()> {
        let exit = Arc::clone(&self.exit);
        let name_container = Arc::clone(&self.names);
        let frequency_container = Arc::clone(&self.shared_adder_frequency);
        let position = Arc::clone(&self.adder_position);
        let reset = Arc::clone(&self.reset);
        let thread = thread::spawn(move || {
            let mut random = rand::thread_rng();
            while exit.load(Ordering::SeqCst) == 0 {
                if reset.load(Ordering::SeqCst) == 1 {
                    let f = frequency_container.get_mut();
                    *f = 0;
                    frequency_container.unlock();
                    let names = name_container.get_mut();
                    for i in 0..names.len() {
                        names[i] = "";
                    }

                    name_container.unlock();
                    let pos = position.get_mut();
                    *pos = None;
                    position.unlock();
                    reset.store(0, Ordering::SeqCst);
                }
                let frequency = frequency_container.get();
                if *frequency != 0 {
                    let min = 500;
                    let max = 2000;
                    let v = (min + (max - min) / 100 * (101 - *frequency)) as u64;

                    frequency_container.unlock();
                    let ms = time::Duration::from_millis(v);
                    thread::sleep(ms);
                    let pos = position.get_mut();
                    *pos = match *pos {
                        Some(mut n) => {
                            if n < TABLE_ROW_SIZE {
                                n += 1;
                            }
                            Some(n)
                        }
                        None => Some(0),
                    };
                    let index = pos.unwrap_or(0);
                    position.unlock();

                    if index < TABLE_ROW_SIZE {
                        let r = random.gen_range(0..USER_ARRAY.len());
                        let names = name_container.get_mut();

                        names[index] = USER_ARRAY[r];

                        name_container.unlock();
                    }
                } else {
                    frequency_container.unlock();
                }
            }
        });
        thread
    }
    fn spawn_reviewer(&mut self) {}

    fn user_table(&self, ui: &mut egui::Ui, table_name: &str, title: &str) {
        ui.vertical(|ui| {
            ui.label(title);
            egui::Frame::none()
                .stroke(egui::Stroke::new(2.0, egui::Color32::GRAY))
                .inner_margin(egui::style::Margin::same(5.0))
                .show(ui, |ui| {
                    egui::ScrollArea::new([false, true]).show(ui, |ui| {
                        egui::Grid::new(table_name).show(ui, |ui| {
                            let names = self.names.get();
                            for i in 0..names.len() {
                                let mut cell_color = egui::Color32::TRANSPARENT;
                                let adder_position = self.adder_position.get();
                                let reviewer_position = self.reviewer_position.get();
                                if *adder_position != None && adder_position == reviewer_position {
                                    cell_color = egui::Color32::LIGHT_BLUE;
                                } else if *adder_position == Some(i) {
                                    cell_color = egui::Color32::LIGHT_GREEN;
                                } else if *reviewer_position == Some(i) {
                                    cell_color = egui::Color32::LIGHT_RED;
                                }
                                self.adder_position.unlock();
                                self.reviewer_position.unlock();
                                egui::Frame::none()
                                    .stroke(egui::Stroke::new(2.0, egui::Color32::GRAY))
                                    .fill(cell_color)
                                    .inner_margin(egui::style::Margin::same(5.0))
                                    .show(ui, |ui| {
                                        ui.add_sized([30.0, 20.0], egui::Label::new(i.to_string()));
                                    });
                                egui::Frame::none()
                                    .stroke(egui::Stroke::new(2.0, egui::Color32::GRAY))
                                    .inner_margin(egui::style::Margin::same(5.0))
                                    .show(ui, |ui| {
                                        ui.add_sized([100.0, 20.0], egui::Label::new(names[i]));
                                    });
                                ui.end_row();
                            }
                            self.names.unlock();
                        });
                    });
                });
        });
    }
    fn table_of_added_users(&self, ui: &mut egui::Ui, table_name: &str, title: &str) {
        ui.vertical(|ui| {
            ui.label(title);
            egui::Frame::none()
                .stroke(egui::Stroke::new(2.0, egui::Color32::GRAY))
                .inner_margin(egui::style::Margin::same(5.0))
                .show(ui, |ui| {
                    egui::ScrollArea::new([false, true]).show(ui, |ui| {
                        egui::Grid::new(table_name).show(ui, |ui| {
                            let names = self.added_names.get();
                            for i in 0..names.len() {
                                egui::Frame::none()
                                    .stroke(egui::Stroke::new(2.0, egui::Color32::GRAY))
                                    .inner_margin(egui::style::Margin::same(5.0))
                                    .show(ui, |ui| {
                                        ui.add_sized([30.0, 20.0], egui::Label::new(i.to_string()));
                                    });
                                egui::Frame::none()
                                    .stroke(egui::Stroke::new(2.0, egui::Color32::GRAY))
                                    .inner_margin(egui::style::Margin::same(5.0))
                                    .show(ui, |ui| {
                                        ui.add_sized([100.0, 20.0], egui::Label::new(names[i]));
                                    });
                                ui.end_row();
                            }
                            self.added_names.unlock();
                        });
                    });
                });
        });
    }
}
