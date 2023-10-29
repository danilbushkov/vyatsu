mod app;
mod defines;
mod fork;
mod philosopher;
mod table;

fn main() -> Result<(), eframe::Error> {
    //env_logger::init(); // Log to stderr (if you run with `RUST_LOG=debug`).
    let vec2 = eframe::egui::Vec2 { x: 800.0, y: 600.0 };
    let options = eframe::NativeOptions {
        min_window_size: Some(vec2),
        default_theme: eframe::Theme::Light,
        //maximized: false,
        //resizable: false,
        ..Default::default()
    };
    eframe::run_native(
        "Task1",
        options,
        Box::new(|cc| {
            // This gives us image support:
            egui_extras::install_image_loaders(&cc.egui_ctx);

            Box::new(app::App::new())
        }),
    )
}
