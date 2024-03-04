use super::super::widgets;
use crate::tasks;
use crate::tiger;
use gtk::prelude::*;
use gtk::{glib, Orientation};
use std::rc::Rc;

pub fn get_task4_page() -> widgets::TaskPage {
    widgets::TaskPage::new(tasks::TASK4_TEXT, &get_hash_area(), &get_hash_area(), None)
}

fn get_hash_area() -> gtk::Box {
    let bx = gtk::Box::new(Orientation::Vertical, 10);
    let text_input = widgets::TextArea::new("Введите текст(Максимум 256 символа):");
    let hash = Rc::new(widgets::TextView::new("Хэш:"));

    let h = Rc::clone(&hash);
    let handler = Box::new(
        glib::clone!(@weak text_input => move |t: &widgets::TextArea| {
            let text = text_input.text();
            let hash = tiger::hash(text.as_bytes());
            h.set_text(&tiger::hash_to_hex_string(hash));
        }),
    );

    text_input.set_input_handler(handler);

    bx.append(text_input.get());
    bx.append(hash.get());
    bx
}
