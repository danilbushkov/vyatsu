use super::MARGIN;
use gtk::prelude::*;
use gtk::{Align, Box, Frame, Label, Orientation, TextView};

pub struct TextArea {
    title: Label,
    text_view: TextView,
    bx: Box,
}

impl TextArea {
    pub fn new(title: &str) -> Self {
        let frame = Frame::builder().build();
        let title = Label::builder().label(title).halign(Align::Start).build();
        let text_view = TextView::builder()
            .wrap_mode(gtk::WrapMode::WordChar)
            .width_request(300)
            .build();
        let bx = Box::builder()
            .orientation(Orientation::Vertical)
            .halign(Align::Fill)
            .build();
        bx.append(&title);
        frame.set_child(Some(&text_view));
        bx.append(&frame);
        text_view.buffer().connect_changed(|b| {
            const MAX: i32 = 256;
            if b.char_count() > MAX {
                let mut start = b.start_iter();
                start.forward_chars(MAX);
                let mut end = b.end_iter();
                b.delete(&mut start, &mut end);
            }
        });
        Self {
            title,
            text_view,
            bx,
        }
    }
    pub fn get(&self) -> &Box {
        &self.bx
    }
}
