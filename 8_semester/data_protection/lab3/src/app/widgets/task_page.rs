use super::MARGIN;
use gtk::prelude::*;
use gtk::{Align, Box, Frame, Label, Orientation, Separator, TextView, Widget};

pub struct TaskPage {
    text_view: TextView,
    bx: Box,
}

impl TaskPage {
    pub fn new(
        task: &str,
        left_widget: &impl IsA<Widget>,
        right_widget: &impl IsA<Widget>,
        bottom_box: Option<&Box>,
    ) -> Self {
        let frame = Frame::builder().build();
        let text_view = TextView::builder().editable(false).build();
        text_view.buffer().set_text(task);
        let bx = Box::builder()
            .margin_end(MARGIN)
            .margin_top(MARGIN)
            .margin_start(MARGIN)
            .margin_bottom(MARGIN)
            .orientation(Orientation::Vertical)
            .spacing(10)
            .build();
        let sp = Separator::builder()
            .margin_start(MARGIN)
            .margin_end(MARGIN)
            .build();

        frame.set_child(Some(&text_view));

        let central_box = Box::builder()
            .orientation(Orientation::Horizontal)
            .spacing(10)
            .build();
        central_box.append(left_widget);
        central_box.append(&Separator::new(Orientation::Vertical));
        central_box.append(right_widget);

        bx.append(&frame);
        bx.append(&sp);
        bx.append(&central_box);
        if let Some(b) = bottom_box {
            let sp = Separator::builder()
                .margin_start(MARGIN)
                .margin_end(MARGIN)
                .build();
            bx.append(&sp);
            bx.append(b);
        }

        TaskPage { text_view, bx }
    }
    pub fn get(&self) -> &Box {
        &self.bx
    }
}
