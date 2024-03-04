use super::super::widgets;
use super::check_str;
use crate::tasks;
use crate::{gost, rsa};
use gtk::prelude::*;
use gtk::{glib, Orientation};
use num::BigUint;
use std::collections::HashSet;
use std::rc::Rc;

pub fn get_key_area() -> gtk::Box {
    let bx = gtk::Box::new(Orientation::Vertical, 10);
    let pub_key = Rc::new(widgets::TextView::new("Публичный ключ"));
    let priv_key = Rc::new(widgets::TextView::new("Приватный ключ"));

    let pk = Rc::clone(&pub_key);
    let pr = Rc::clone(&priv_key);
    let button = gtk::Button::builder().label("Сгенерировать").build();
    button.connect_clicked(move |_| {
        let keys = rsa::new_keys(BigUint::from(659 as u32), BigUint::from(599 as u32));
        let keys = (format!("{} {}", keys.0.0, keys.0.1), format!("{} {}", keys.1.0, keys.1.1));
        pk.set_text(&keys.0);
        pr.set_text(&keys.1);
    });

    bx.append(pub_key.get());
    bx.append(priv_key.get());
    bx.append(&button);
    bx
}

fn encrypt(text: &str, key: &str) -> String {
    let mut key_blocks = BigUint::parse_bytes(key.as_bytes(), 10)
        .unwrap_or(BigUint::from(0 as u32))
        .to_u32_digits();
    key_blocks.resize(8, 0);
    let cipherbytes = gost::encrypt(
        text.as_bytes(),
        &key_blocks[0..8].try_into().unwrap(),
        &gost::TASK_SBOX,
    );
    cipherbytes
        .iter()
        .map(|b| format!("{:02x}", b))
        .collect::<Vec<_>>()
        .join("")
}
fn decrypt(ciphertext: &str, key: &str) -> String {
    let s = ciphertext;
    let mut key_blocks = BigUint::parse_bytes(key.as_bytes(), 10)
        .unwrap_or(BigUint::from(0 as u32))
        .to_u32_digits();
    key_blocks.resize(8, 0);
    let cipherbytes: Vec<u8> = (0..s.len())
        .step_by(2)
        .map(|i| {
            if i + 2 <= s.len() {
                return u8::from_str_radix(&s[i..i + 2], 16).unwrap_or(0);
            } else {
                return u8::from_str_radix(&((&s[i..i + 1]).to_owned() + "0"), 16).unwrap_or(0);
            }
        })
        .collect();

    let mut bytes = gost::decrypt(
        &cipherbytes,
        &key_blocks[0..8].try_into().unwrap(),
        &gost::TASK_SBOX,
    );
    while bytes.last() != None && bytes.last() == Some(&0) {
        bytes.pop();
    }
    String::from_utf8_lossy(&bytes).to_string()
}

pub fn get_task3_page() -> widgets::TaskPage {
    let decryption = gtk::Box::new(Orientation::Vertical, 10);
    let ciphertext_input = widgets::TextArea::new(
        "Введите шифртекст(Максимум 256 символа; 
символ - шестнадцатеричное число: 0..f):",
    );
    let key_input = widgets::TextArea::new(
        "Введите ключ в виде десятичного числа
(Должен быть представлен не больше 256 битами, 
иначе число будет обрезаться):",
    );
    let text = Rc::new(widgets::TextView::new("Текст:"));
    let tx = Rc::clone(&text);
    let t2 = Rc::clone(&text);

    let v = ('0'..='9').collect::<Vec<_>>();
    let mut a: Vec<char> = ('a'..='f').collect::<Vec<_>>();
    a.append(&mut v.clone());

    let chars: Rc<HashSet<char>> = Rc::new(v.into_iter().collect());
    let cipher_chars: Rc<HashSet<char>> = Rc::new(a.into_iter().collect());

    let ch = Rc::clone(&chars);
    let cch = Rc::clone(&cipher_chars);
    let handler = Box::new(
        glib::clone!(@weak key_input => move |t: &widgets::TextArea| {
            let ciphertext = t.text();
            let key = key_input.text();

            if let Ok(_) = check_str(&key, &chars){

                if let Err(e) = check_str(&ciphertext, &cipher_chars) {
                    t.set_error(&e);
                } else {
                    let text = &decrypt(&ciphertext, &key);

                    tx.set_text(text);
                }
            }
        }),
    );

    ciphertext_input.set_input_handler(handler);

    let handler = Box::new(
        glib::clone!(@weak ciphertext_input => move |t: &widgets::TextArea| {
            let key = t.text();
            let ciphertext = ciphertext_input.text();

            if let Err(e)= check_str(&key, &ch) {
                t.set_error(&e);
            } else {
                if let Ok(_) = check_str(&ciphertext, &cch) {
                    let text = &decrypt(&ciphertext, &key);
                    t2.set_text(text);
                }
            }
        }),
    );

    key_input.set_input_handler(handler);
    decryption.append(ciphertext_input.get());
    decryption.append(key_input.get());
    decryption.append(text.get());
    widgets::TaskPage::new(
        tasks::TASK3_TEXT,
        &get_encryption_area(),
        &decryption,
        Some(&get_key_area()),
    )
}

fn get_encryption_area() -> gtk::Box {
    let encryption = gtk::Box::new(Orientation::Vertical, 10);
    let text_input = widgets::TextArea::new("Введите текст(Максимум 256 символа):");
    let key_input = widgets::TextArea::new(
        "Введите ключ в виде десятичного числа
(Должен быть представлен не больше 256 битами, 
иначе число будет обрезаться):",
    );
    let ciphertext = Rc::new(widgets::TextView::new("Зашифрованный текст:"));
    let ct = Rc::clone(&ciphertext);
    let ct2 = Rc::clone(&ciphertext);

    let v = ('0'..='9').collect::<Vec<_>>();

    let chars: Rc<HashSet<char>> = Rc::new(v.into_iter().collect());
    let ch = Rc::clone(&chars);
    let handler = Box::new(
        glib::clone!(@weak key_input => move |t: &widgets::TextArea| {
            let text = t.text();
            let key = key_input.text();

            if let Ok(_) = check_str(&key, &chars){
                let ciphertext = &encrypt(&text, &key);
                ct.set_text(ciphertext);
            }
        }),
    );

    text_input.set_input_handler(handler);

    let handler = Box::new(
        glib::clone!(@weak text_input => move |t: &widgets::TextArea| {
            let key = t.text();
            let text = text_input.text();

            if let Err(e)= check_str(&key, &ch) {
                t.set_error(&e);
            } else {
                let ciphertext = &encrypt(&text, &key);
                ct2.set_text(ciphertext);
            }
        }),
    );

    key_input.set_input_handler(handler);
    encryption.append(text_input.get());
    encryption.append(key_input.get());
    encryption.append(ciphertext.get());
    encryption
}
