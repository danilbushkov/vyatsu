use super::super::widgets;
use super::check_str;
use crate::rsa;
use crate::tasks;
use gtk::prelude::*;
use gtk::{glib, Orientation};
use num::{BigUint, Num, ToPrimitive};
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
        let keys = (
            format!("{} {}", keys.0 .0, keys.0 .1),
            format!("{} {}", keys.1 .0, keys.1 .1),
        );
        pk.set_text(&keys.0);
        pr.set_text(&keys.1);
    });

    bx.append(pub_key.get());
    bx.append(priv_key.get());
    bx.append(&button);
    bx
}

pub fn get_key(key: &str) -> Result<(BigUint, BigUint), String> {
    let mut v = ('0'..='9').collect::<Vec<_>>();
    v.push(' ');

    let chars: Rc<HashSet<char>> = Rc::new(v.into_iter().collect());
    check_str(key, &chars)?;
    let key: Vec<BigUint> = key
        .trim()
        .split_whitespace()
        .map(|s| BigUint::parse_bytes(s.as_bytes(), 10).unwrap_or(BigUint::from(0 as u32)))
        .collect();
    if key.len() > 2 {
        return Err("Слишком большое количество чисел в ключе".to_owned());
    } else if key.len() < 2 {
        return Err("Не хватает чисел в ключе".to_owned());
    } else if key[0] > BigUint::from(5000 as u32) {
        return Err("Слишком большое число для возведения в степень".to_owned());
    }

    Ok((key[0].clone(), key[1].clone()))
}

pub fn get_cipher_blocks(ciphertext: &str) -> Result<Vec<BigUint>, String> {
    let mut v = ('0'..='9').collect::<Vec<_>>();
    v.append(&mut ('a'..='f').collect::<Vec<_>>());
    v.push('.');

    let chars: Rc<HashSet<char>> = Rc::new(v.into_iter().collect());
    check_str(ciphertext, &chars)?;

    let c = ciphertext
        .split('.')
        .map(|s| BigUint::from_str_radix(s, 16).unwrap_or(BigUint::from(0 as u32)))
        .collect::<Vec<_>>();
    Ok(c)
}

pub fn encrypt(text: &str, key: &(BigUint, BigUint)) -> String {
    let c = rsa::encrypt(text.as_bytes(), key);
    let s: String = c
        .iter()
        .map(|v| v.to_str_radix(16))
        .collect::<Vec<_>>()
        .join(".");
    s
}

pub fn decrypt(cipherblocks: &[BigUint], key: &(BigUint, BigUint)) -> String {
    let m = rsa::decrypt(cipherblocks, key);
    let bytes: Vec<u8> = m.iter().map(|b| b.to_u8().unwrap_or(0)).collect();
    String::from_utf8_lossy(&bytes).to_string()
}

pub fn get_task3_page() -> widgets::TaskPage {
    let decryption = gtk::Box::new(Orientation::Vertical, 10);
    let ciphertext_input = widgets::TextArea::new(
        "Введите шифртекст(Максимум 512 символа; 
символ - шестнадцатеричное число: 0..f и точка):",
    );
    ciphertext_input.set_max(512);
    let key_input = widgets::TextArea::new("Введите приватный ключ:");
    let text = Rc::new(widgets::TextView::new("Текст:"));
    let tx = Rc::clone(&text);
    let t2 = Rc::clone(&text);

    let v = ('0'..='9').collect::<Vec<_>>();
    let mut a: Vec<char> = ('a'..='f').collect::<Vec<_>>();
    a.append(&mut v.clone());

    let handler = Box::new(
        glib::clone!(@weak key_input => move |t: &widgets::TextArea| {
            let ciphertext = t.text();
            let key = key_input.text();

              match get_cipher_blocks(&ciphertext) {
                Ok(bs) => {
                    match get_key(&key) {
                    Ok(k) => {
                        let text = decrypt(&bs, &k);
                        tx.set_text(&text);
                    }
                    Err(_) => ()
                    }
                }
                Err(e) => t.set_error(&e)
            }
        }),
    );

    ciphertext_input.set_input_handler(handler);

    let handler = Box::new(
        glib::clone!(@weak ciphertext_input => move |t: &widgets::TextArea| {
            let key = t.text();
            let ciphertext = ciphertext_input.text();
            if let Ok(bs) = get_cipher_blocks(&ciphertext) {
                match get_key(&key) {
                Ok(k) => {
                    let text = decrypt(&bs, &k);
                    t2.set_text(&text);
                }
                Err(e) => t.set_error(&e)
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
    let key_input = widgets::TextArea::new("Введите публичный ключ:");
    let ciphertext = Rc::new(widgets::TextView::new("Зашифрованный текст:"));
    let ct = Rc::clone(&ciphertext);
    let ct2 = Rc::clone(&ciphertext);

    let handler = Box::new(
        glib::clone!(@weak key_input => move |t: &widgets::TextArea| {
            let text = t.text();
            let key = key_input.text();
            let r = get_key(&key);
            match r {
                Ok(k) => {
                    let ciphertext = &encrypt(&text, &k);
                    ct.set_text(ciphertext);
                },
                Err(_) => ()
            }
        }),
    );

    text_input.set_input_handler(handler);

    let handler = Box::new(
        glib::clone!(@weak text_input => move |t: &widgets::TextArea| {
            let key = t.text();
            let text = text_input.text();


            let r = get_key(&key);
            match r {
                Ok(k) => {
                    let ciphertext = &encrypt(&text, &k);
                    ct2.set_text(ciphertext);
                },
                Err(e) =>t.set_error(&e),
            }
        }),
    );

    key_input.set_input_handler(handler);
    encryption.append(text_input.get());
    encryption.append(key_input.get());
    encryption.append(ciphertext.get());
    encryption
}
