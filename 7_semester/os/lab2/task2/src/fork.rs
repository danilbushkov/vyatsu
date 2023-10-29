use eframe::egui::mutex::Mutex;
use eframe::egui::Pos2;

pub struct Fork {
    pos: Pos2,
    visible: Mutex<bool>,
}

impl Fork {
    pub fn new(pos: Pos2, visible: bool) -> Self {
        Self {
            pos,
            visible: Mutex::new(visible),
        }
    }
    pub fn get_pos(&self) -> Pos2 {
        self.pos
    }
    pub fn is_visible(&self) -> bool {
        *self.visible.lock()
    }
    pub fn visible(&self, visible: bool) {
        *self.visible.lock() = visible;
    }
}
