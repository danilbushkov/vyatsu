mod gost;
mod polybius_square;
mod rsa;
mod tasks;
mod tiger;

use gtk::prelude::*;
use gtk::{
    glib, Application, ApplicationWindow, Box, Button, Label, Orientation, Paned, Stack,
    StackSidebar,
};
use num_bigint::{BigInt, BigUint};

const APP_ID: &str = "org.gtk_rs.HelloWorld1";

fn main() {
    //-> glib::ExitCode {
    //let app = Application::builder().application_id(APP_ID).build();
    //app.connect_activate(build_ui);
    //app.run()
    let (x, _, _) = rsa::gcd(BigInt::from(23), BigInt::from(2341));
    println!("{}", x);
}

fn build_ui(app: &Application) {
    const MARGIN: i32 = 10;
    let paned = Paned::builder()
        .orientation(Orientation::Horizontal)
        .shrink_start_child(false)
        .shrink_end_child(false)
        .build();
    let stack = Stack::builder().build();
    let task1_box = Box::new(Orientation::Vertical, 0);
    let task1_description = Label::builder()
        .label(tasks::TASK1_TEXT)
        .margin_end(MARGIN)
        .margin_top(MARGIN)
        .margin_start(MARGIN)
        .margin_bottom(MARGIN)
        .build();
    let task1_button = Button::builder()
        .label("Расшифровать")
        .margin_end(MARGIN)
        .margin_top(MARGIN)
        .margin_start(MARGIN)
        .margin_bottom(MARGIN)
        .build();
    let task1_answer = Label::builder()
        .label("")
        .margin_end(MARGIN)
        .margin_top(MARGIN)
        .margin_start(MARGIN)
        .margin_bottom(MARGIN)
        .build();

    task1_button.connect_clicked(glib::clone!(@weak task1_answer => move |_| {
            let title = "Ответ: ".to_owned();

            let text = title + polybius_square::decrypt_from_str(tasks::TASK1_STR).as_str();
            task1_answer.set_label(&text);
    }));
    task1_box.append(&task1_description);
    task1_box.append(&task1_button);
    task1_box.append(&task1_answer);

    let task2_box = Box::new(Orientation::Vertical, 0);
    let task2_encrypt_button = Button::builder()
        .label("Зашифровать")
        .margin_end(MARGIN)
        .margin_top(MARGIN)
        .margin_start(MARGIN)
        .margin_bottom(MARGIN)
        .build();
    task2_box.append(
        &Label::builder()
            .label(tasks::TASK2_TEXT)
            .margin_end(MARGIN)
            .margin_top(MARGIN)
            .margin_start(MARGIN)
            .margin_bottom(MARGIN)
            .build(),
    );

    task2_encrypt_button.connect_clicked(move |_| {
        let mut key_blocks = BigUint::parse_bytes(tasks::TASK2_KEY, 10)
            .unwrap()
            .to_u32_digits();
        key_blocks.resize(8, 0);
        let cipherbytes = gost::encrypt(
            tasks::TASK2_STR.as_bytes(),
            &key_blocks[0..8].try_into().unwrap(),
            &gost::SBOX,
        );
        let s = tasks::TASK2_STR;
        println!("{}", s);

        println!("{:?}; {}", s.as_bytes(), s.len());
        println!("\ncipher: {:?}; {}", cipherbytes, cipherbytes.len());
        let bytes = gost::decrypt(
            &cipherbytes,
            &key_blocks[0..8].try_into().unwrap(),
            &gost::SBOX,
        );
        let d = String::from_utf8_lossy(&bytes);

        println!("\nText: {:?}; {}", bytes, bytes.len());
        println!("{}", d);
    });
    task2_box.append(&task2_encrypt_button);

    stack.add_titled(&task1_box, Some("task1_box"), "Задание 1");
    stack.add_titled(&task2_box, Some("task2_box"), "Задание 2");
    let sidebar = StackSidebar::builder().build();
    sidebar.set_stack(&stack);

    paned.set_start_child(Some(&sidebar));
    paned.set_end_child(Some(&stack));
    let window = ApplicationWindow::builder()
        .application(app)
        .title("Lab3")
        .child(&paned)
        .resizable(false)
        .build();

    window.present();

    //debug
    let hash = tiger::hash("Tiger".as_bytes());
    println!("{}", tiger::hash_to_hex_string(hash));
}
