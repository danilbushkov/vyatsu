use eframe::egui;

pub struct App {
    name: String,
    adder_frequency: i32,
    reviewer_frequency: i32,
    task_window_open: bool,
}

impl Default for App {
    fn default() -> Self {
        Self {
            name: "Test".to_owned(),
            adder_frequency: 0,
            reviewer_frequency: 0,
            task_window_open: false,
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
            //});
            ui.group(|ui| {
                ui.label("Таблица пользователей");
                egui::Frame::none()
                    .stroke(egui::Stroke::new(2.0, egui::Color32::GRAY))
                    .inner_margin(egui::style::Margin::same(5.0))
                    .show(ui, |ui| {
                        egui::ScrollArea::new([true, true]).show(ui, |ui| {
                            egui::Grid::new("grid").show(ui, |ui| {
                                for i in 0..300 {
                                    egui::Frame::none()
                                        .stroke(egui::Stroke::new(2.0, egui::Color32::GRAY))
                                        .inner_margin(egui::style::Margin::same(5.0))
                                        .show(ui, |ui| {
                                            ui.add_sized(
                                                [30.0, 20.0],
                                                egui::Label::new(i.to_string()),
                                            );
                                        });
                                    egui::Frame::none()
                                        .stroke(egui::Stroke::new(2.0, egui::Color32::GRAY))
                                        .inner_margin(egui::style::Margin::same(5.0))
                                        .show(ui, |ui| {
                                            ui.add_sized([100.0, 20.0], egui::Label::new(""));
                                        });
                                    ui.end_row();
                                }
                            });
                        });
                        //    });
                    });
            });
        });
    }
}
