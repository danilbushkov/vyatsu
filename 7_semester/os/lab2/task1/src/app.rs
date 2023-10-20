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
            //ui.with_layout(egui::Layout::top_down(egui::Align::Center), |ui| {
            //    ui.label("world!");
            //    ui.label("Hello");
            //});
            ui.with_layout(egui::Layout::top_down(egui::Align::Center), |ui| {
                egui::ScrollArea::new([true, true]).show(ui, |ui| {
                    egui::Grid::new("some_unique_id")
                        .min_col_width(200.0)
                        .show(ui, |ui| {
                            for i in 0..100 {
                                egui::Frame::none()
                                    .stroke(egui::Stroke::new(1.0, egui::Color32::GRAY))
                                    .inner_margin(egui::style::Margin::same(5.0))
                                    .show(ui, |ui| {
                                        ui.label(i.to_string());
                                    });
                                ui.end_row();
                            }
                        });
                });
            });
        });
    }
}
