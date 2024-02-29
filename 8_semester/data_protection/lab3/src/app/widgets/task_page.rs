use super::MARGIN;
use gtk::prelude::*;
use gtk::{Box, Frame, Label, Orientation, TextView, Widget};

pub struct TaskPage {
    text_view: TextView,
    bx: Box,
}

impl TaskPage {
    pub fn new(task: &str, widget: &impl IsA<Widget>) -> Self {
        let frame = Frame::builder()
            .margin_end(MARGIN)
            .margin_top(MARGIN)
            .margin_start(MARGIN)
            .margin_bottom(MARGIN)
            .build();
        let text_view = TextView::builder().editable(false).build();
        text_view.buffer().set_text(task);
        let bx = Box::new(Orientation::Vertical, 0);
        frame.set_child(Some(&text_view));
        bx.append(&frame);
        bx.append(widget);
        TaskPage { text_view, bx }
    }
    pub fn get(&self) -> &Box {
        &self.bx
    }
}
