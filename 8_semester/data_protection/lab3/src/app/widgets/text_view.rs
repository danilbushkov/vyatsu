use gtk::prelude::*;
use gtk::{glib, Align, Box, Frame, Label, Orientation};

pub struct TextView {
    title: Label,
    text_view: gtk::TextView,
    bx: Box,
}

impl TextView {
    pub fn new(title: &str) -> Self {
        let title = Label::builder().label(title).halign(Align::Start).build();
        let frame = Frame::builder().build();
        let text_view = gtk::TextView::builder()
            .editable(false)
            .wrap_mode(gtk::WrapMode::WordChar)
            .build();

        frame.set_child(Some(&text_view));
        let bx = Box::new(Orientation::Vertical, 0);
        bx.append(&title);
        bx.append(&frame);

        Self {
            title,
            text_view,
            bx,
        }
    }
    pub fn get(&self) -> &Box {
        &self.bx
    }
    pub fn set_text(&self, text: &str) {
        let b = self.text_view.buffer();
        let result = glib::GString::from_string_checked(text.to_owned());
        match result {
            Ok(s) => b.set_text(&s),
            Err(_) => b.set_text("Ошибка конвертации"),
        }
    }
    pub fn text(&self) -> String {
        let b = self.text_view.buffer();
        b.text(&b.start_iter(), &b.end_iter(), false).to_string()
    }
}
