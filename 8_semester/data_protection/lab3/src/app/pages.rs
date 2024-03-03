use super::widgets;
use crate::tasks;
use gtk::prelude::*;
use gtk::{Box, Orientation};

pub fn get_task1_page() -> widgets::TaskPage {
    let encryption = Box::new(Orientation::Vertical, 0);
    let text_input = widgets::TextArea::new("Введите текст:");
    let ciphertext = widgets::TextView::new("Зашифрованный текст:");

    encryption.append(text_input.get());
    encryption.append(ciphertext.get());

    let text_area1 = widgets::TextArea::new("Введите текст:");

    widgets::TaskPage::new(tasks::TASK1_TEXT, &encryption, text_area1.get(), None)
}
