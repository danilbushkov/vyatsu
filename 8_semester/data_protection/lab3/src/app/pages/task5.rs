use super::super::widgets;
use super::task3::*;
use crate::tasks;
use crate::tiger;
use gtk::prelude::*;
use gtk::{glib, Orientation};
use std::rc::Rc;

fn check(text_hash: &str, hash: &str) -> String {
    if text_hash == hash {
        return "Текст является подписаным".to_owned();
    }
    return "Текст не является подписанным".to_owned();
}

pub fn get_task5_page() -> widgets::TaskPage {
    let decryption = gtk::Box::new(Orientation::Vertical, 10);
    let text_input = widgets::TextArea::new("Введите текст(Максимум 256 символа):");
    let text_hash = Rc::new(widgets::TextView::new("Хэш текста:"));
    let result_label = gtk::Label::new(None);

    let ciphertext_input = widgets::TextArea::new(
        "Введите подпись(Максимум 512 символа; 
символ - шестнадцатеричное число: 0..f и точка):",
    );
    ciphertext_input.set_max(512);
    let key_input = widgets::TextArea::new("Введите публичный ключ:");
    let hash = Rc::new(widgets::TextView::new("Хэш:"));
    let h = Rc::clone(&hash);

    let v = ('0'..='9').collect::<Vec<_>>();
    let mut a: Vec<char> = ('a'..='f').collect::<Vec<_>>();
    a.append(&mut v.clone());

    let th = Rc::clone(&text_hash);
    let handler = Box::new(
        glib::clone!(@weak key_input, @weak result_label => move |t: &widgets::TextArea| {
            let ciphertext = t.text();
            let key = key_input.text();

              match get_cipher_blocks(&ciphertext) {
                Ok(bs) => {
                    match get_key(&key) {
                    Ok(k) => {
                        let text = decrypt(&bs, &k);
                        h.set_text(&text);

                        result_label.set_text(&check(&th.text(),&text));
                    }

                    Err(_) => ()
                    }
                }
                Err(e) => t.set_error(&e)
            }
        }),
    );

    let h = Rc::clone(&hash);
    ciphertext_input.set_input_handler(handler);

    let th = Rc::clone(&text_hash);
    let handler = Box::new(
        glib::clone!(@weak ciphertext_input, @weak result_label => move |t: &widgets::TextArea| {
            let key = t.text();
            let ciphertext = ciphertext_input.text();
            if let Ok(bs) = get_cipher_blocks(&ciphertext) {
                match get_key(&key) {
                Ok(k) => {
                    let text = decrypt(&bs, &k);

                    h.set_text(&text);

                    result_label.set_text(&check(&th.text(),&text));
                }
                Err(e) => t.set_error(&e)
                }
            }

        }),
    );

    key_input.set_input_handler(handler);
    let th = Rc::clone(&text_hash);
    let h = Rc::clone(&hash);
    let handler = Box::new(
        glib::clone!(@weak text_input, @weak result_label => move |_: &widgets::TextArea| {
            let text = text_input.text();
            let hash = tiger::hash(text.as_bytes());
            let hash = tiger::hash_to_hex_string(hash);
            th.set_text(&hash);
            result_label.set_text(&check(&h.text(),&hash));
        }),
    );
    text_input.set_input_handler(handler);
    decryption.append(text_input.get());
    decryption.append(text_hash.get());
    decryption.append(&gtk::Separator::builder().build());
    decryption.append(ciphertext_input.get());
    decryption.append(key_input.get());
    decryption.append(hash.get());
    decryption.append(&result_label);
    widgets::TaskPage::new(
        tasks::TASK5_TEXT,
        &get_encryption_area(),
        &decryption,
        Some(&get_key_area()),
    )
}

fn get_encryption_area() -> gtk::Box {
    let encryption = gtk::Box::new(Orientation::Vertical, 10);
    let text_input = widgets::TextArea::new("Введите текст(Максимум 256 символа):");
    let hash = Rc::new(widgets::TextView::new("Хэш: "));
    let key_input = widgets::TextArea::new("Введите приватный ключ:");
    let ciphertext = Rc::new(widgets::TextView::new("Подпись:"));
    let ct = Rc::clone(&ciphertext);
    let ct2 = Rc::clone(&ciphertext);

    let h = Rc::clone(&hash);
    let handler = Box::new(
        glib::clone!(@weak key_input => move |t: &widgets::TextArea| {
            let text = t.text();
            let hash = tiger::hash_to_hex_string(tiger::hash(text.as_bytes()));
            h.set_text(&hash);
            let key = key_input.text();
            let r = get_key(&key);
            match r {
                Ok(k) => {
                    let ciphertext = &encrypt(&hash, &k);
                    ct.set_text(ciphertext);
                },
                Err(_) => ()
            }
        }),
    );

    text_input.set_input_handler(handler);

    let h = Rc::clone(&hash);
    let handler = Box::new(move |t: &widgets::TextArea| {
        let key = t.text();
        let hash = h.text();

        let r = get_key(&key);
        match r {
            Ok(k) => {
                let ciphertext = &encrypt(&hash, &k);
                ct2.set_text(ciphertext);
            }
            Err(e) => t.set_error(&e),
        }
    });

    key_input.set_input_handler(handler);
    encryption.append(text_input.get());
    encryption.append(hash.get());
    encryption.append(key_input.get());
    encryption.append(ciphertext.get());
    encryption
}
