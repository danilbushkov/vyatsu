use super::widgets;
use crate::polybius_square;
use crate::tasks;
use gtk::prelude::*;
use gtk::{Orientation, TextBuffer};
use std::collections::HashSet;
use std::rc::Rc;

fn check_str(text: &str, valid_chars: &HashSet<char>) -> Result<(), String> {
    for ch in text.chars() {
        if !valid_chars.contains(&ch) {
            return Err(format!("Введен некорректный символ: {}", ch));
        }
    }

    Ok(())
}

pub fn get_task1_page() -> widgets::TaskPage {
    let encryption = gtk::Box::new(Orientation::Vertical, 10);
    let text_input = widgets::TextArea::new(
        "Введите текст(только русский алфавит, 
пробелы, точки и запятые; 
максимум 256 символа):",
    );

    let ciphertext = Rc::new(widgets::TextView::new("Зашифрованный текст:"));
    let ct = Rc::clone(&ciphertext);

    let mut chars = ('А'..='Я').collect::<Vec<_>>();
    chars.append(&mut vec![',', ' ', '.']);
    chars.append(&mut ('а'..='я').collect());
    let chars: HashSet<char> = chars.into_iter().collect();

    let handler = Box::new(move |t: &widgets::TextArea| {
        let text = t.text();
        if let Err(e) = check_str(&text, &chars) {
            t.set_error(&e);
        } else {
            let text = text.to_uppercase();
            let ciphertext = &polybius_square::encrypt(&text);
            ct.set_text(ciphertext);
        }
    });

    text_input.set_input_handler(handler);

    encryption.append(text_input.get());
    encryption.append(ciphertext.get());

    let text_area1 = widgets::TextArea::new("Введите текст:");

    widgets::TaskPage::new(tasks::TASK1_TEXT, &encryption, text_area1.get(), None)
}
