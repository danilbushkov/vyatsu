use eframe::egui;

use crate::defines::TABLE_ROW_SIZE;
use std::sync::atomic::{AtomicUsize, Ordering};
use std::sync::Arc;
use std::{hint, thread};

pub struct App {
    _name: String,
    adder_frequency: i32,
    reviewer_frequency: i32,
    task_window_open: bool,
    threads: Vec<std::thread::JoinHandle<()>>,
    exit: Arc<AtomicUsize>,
    name_spinlocks: Vec<Arc<AtomicUsize>>,
    names: Vec<String>,
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
            });

        egui::CentralPanel::default().show(ctx, |ui| {
            //ui.with_layout(
            //    egui::Layout::top_down_justified(egui::Align::Center),
            //    |ui| {
            //    ui.label("world!");
            //    ui.label("Hello");
            self.table(ui);
        });
    }
}

impl App {
    pub fn new() -> Self {
        let mut names: Vec<_> = vec![];
        let mut name_spinlocks: Vec<_> = vec![];
        for _ in 0..TABLE_ROW_SIZE {
            names.push("".to_owned());
            name_spinlocks.push(Arc::new(AtomicUsize::new(0)));
        }
        Self {
            _name: "Test".to_owned(),
            adder_frequency: 0,
            reviewer_frequency: 0,
            task_window_open: false,
            exit: Arc::new(AtomicUsize::new(0)),
            threads: vec![],
            names,
            name_spinlocks,
        }
    }
    fn spawn_adder(&mut self) {}
    fn spawn_reviewer(&mut self) {}

    fn table(&self, ui: &mut egui::Ui) {
        ui.group(|ui| {
            ui.label("Таблица пользователей");
            egui::Frame::none()
                .stroke(egui::Stroke::new(2.0, egui::Color32::GRAY))
                .inner_margin(egui::style::Margin::same(5.0))
                .show(ui, |ui| {
                    egui::ScrollArea::new([true, true]).show(ui, |ui| {
                        egui::Grid::new("grid").show(ui, |ui| {
                            for i in 0..TABLE_ROW_SIZE {
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
                                        //
                                        ui.add_sized(
                                            [100.0, 20.0],
                                            egui::Label::new(&self.names[i]),
                                        );
                                        //
                                    });
                                ui.end_row();
                            }
                        });
                    });
                    //    });
                });
        });
    }
}
