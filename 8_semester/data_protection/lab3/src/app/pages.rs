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

fn count_numbers(text: &str) -> u32 {
    let mut count = 0;
    for ch in text.chars() {
        if ch > '0' && ch < '7' {
            count += 1;
        }
    }
    count
}

pub fn get_task1_page() -> widgets::TaskPage {
    let encryption = gtk::Box::new(Orientation::Vertical, 10);
    let text_input = widgets::TextArea::new(
        "Введите текст(только русский алфавит, 
пробелы, точки и запятые; максимум 256 символа):",
    );

    let ciphertext = Rc::new(widgets::TextView::new("Зашифрованный текст:"));
    let ct = Rc::clone(&ciphertext);

    let mut chars = ('А'..='Я').collect::<Vec<_>>();
    chars.append(&mut vec![',', ' ', '.', '\n']);
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

    let ciphertext_input = widgets::TextArea::new(
        "Введите шифртекст(четное количество цифр; 
цифра из диапазона 1..6):",
    );
    let text = Rc::new(widgets::TextView::new("Текст: "));
    let tx = Rc::clone(&text);
    let decryption = gtk::Box::new(Orientation::Vertical, 10);

    let mut chars = ('1'..='6').collect::<Vec<_>>();
    chars.push(' ');
    chars.push('\n');

    let chars: HashSet<char> = chars.into_iter().collect();
    let handler = Box::new(move |t: &widgets::TextArea| {
        let text = t.text();
        if let Err(e) = check_str(&text, &chars) {
            t.set_error(&e);
        } else if count_numbers(&text) % 2 == 1 {
            t.set_error("Должно быть четное количество цифр.");
        } else {
            let text = text.to_uppercase();

            let ciphertext = &polybius_square::decrypt_from_str(&text);
            tx.set_text(ciphertext);
        }
    });
    ciphertext_input.set_input_handler(handler);

    decryption.append(ciphertext_input.get());
    decryption.append(text.get());

    widgets::TaskPage::new(tasks::TASK1_TEXT, &encryption, &decryption, None)
}
