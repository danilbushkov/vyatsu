use super::ErrorLabel;
use gtk::prelude::*;
use gtk::{glib, Align, Frame, Label, Orientation, TextBuffer, TextView};
use std::cell::RefCell;
use std::rc::Rc;

pub struct TextArea {
    title: Label,
    text_view: TextView,
    error_label: Rc<ErrorLabel>,
    bx: gtk::Box,
    input_handler: Rc<RefCell<Box<dyn Fn(&Self)>>>,
}

impl TextArea {
    pub fn new(title: &str) -> Rc<Self> {
        let frame = Frame::builder().build();
        let title = Label::builder().label(title).halign(Align::Start).build();
        let text_view = TextView::builder()
            .wrap_mode(gtk::WrapMode::WordChar)
            .width_request(300)
            .build();
        let bx = gtk::Box::builder()
            .orientation(Orientation::Vertical)
            .halign(Align::Fill)
            .build();
        let error_label = Rc::new(ErrorLabel::new());
        bx.append(&title);
        frame.set_child(Some(&text_view));
        bx.append(&frame);
        bx.append(error_label.get());
        let handler: Box<dyn Fn(&Self)> = Box::new(|_| {});
        let input_handler = Rc::new(RefCell::new(handler));

        let i_h = Rc::clone(&input_handler);

        let s = Rc::new(Self {
            title,
            text_view,
            bx,
            error_label,
            input_handler,
        });

        let c_s = Rc::clone(&s);

        s.text_view.buffer().connect_changed(move |b| {
            c_s.set_error("");
            const MAX: i32 = 256;
            i_h.borrow()(&c_s);
            if b.char_count() > MAX {
                let mut start = b.start_iter();
                start.forward_chars(MAX);
                let mut end = b.end_iter();
                b.delete(&mut start, &mut end);
            }
        });
        s
    }
    pub fn get(&self) -> &gtk::Box {
        &self.bx
    }
    pub fn set_input_handler(&self, handler: Box<dyn Fn(&Self)>) {
        *self.input_handler.borrow_mut() = handler;
    }
    pub fn text(&self) -> String {
        let b = self.text_view.buffer();
        b.text(&b.start_iter(), &b.end_iter(), false).to_string()
    }
    pub fn set_text(&self, text: &str) {
        let b = self.text_view.buffer();
        b.set_text(text);
    }
    pub fn set_error(&self, text: &str) {
        self.error_label.set_text(text);
    }
}
