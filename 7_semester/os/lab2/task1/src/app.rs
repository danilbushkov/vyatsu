use eframe::egui;

pub struct App {
    name: String,
}

impl Default for App {
    fn default() -> Self {
        Self {
            name: "Test".to_owned(),
        }
    }
}

impl eframe::App for App {
    fn update(&mut self, ctx: &egui::Context, _frame: &mut eframe::Frame) {
        egui::CentralPanel::default().show(ctx, |ui| {
            ui.heading("Application");
            ui.horizontal(|ui| {
                let name_label = ui.label("Name: ");
                ui.text_edit_singleline(&mut self.name)
                    .labelled_by(name_label.id);
            });
            ui.label(format!("Hello '{}'", self.name));
        });
    }
}
