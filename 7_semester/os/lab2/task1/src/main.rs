mod app;

use eframe::egui;

fn main() -> Result<(), eframe::Error> {
    //env_logger::init(); // Log to stderr (if you run with `RUST_LOG=debug`).
    let options = eframe::NativeOptions {
        initial_window_size: Some(egui::vec2(320.0, 240.0)),
        default_theme: eframe::Theme::Light,
        maximized: false,
        resizable: false,
        ..Default::default()
    };
    eframe::run_native(
        "Task1",
        options,
        Box::new(|_| {
            // This gives us image support:
            //egui_extras::install_image_loaders(&cc.egui_ctx);

            Box::<app::App>::default()
        }),
    )
}
