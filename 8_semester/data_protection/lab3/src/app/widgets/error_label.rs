use gtk::prelude::*;
use gtk::{glib, Align, Label};

pub struct ErrorLabel {
    label: Label,
}

impl ErrorLabel {
    pub fn new() -> Self {
        let label = Label::builder().halign(Align::Start).build();

        Self { label }
    }

    pub fn get(&self) -> &Label {
        &self.label
    }

    pub fn set_text(&self, text: &str) {
        let text = &glib::markup_escape_text(text);
        let s = "<span foreground='red'>".to_owned() + text + "</span>";
        self.label.set_markup(&s);
    }
}
