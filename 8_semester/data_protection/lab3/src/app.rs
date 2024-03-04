mod pages;
mod widgets;

use crate::tiger;
use gtk::prelude::*;
use gtk::{Application, ApplicationWindow, Orientation, Paned, Stack, StackSidebar};

pub fn build_ui(app: &Application) {
    let paned = Paned::builder()
        .orientation(Orientation::Horizontal)
        .shrink_start_child(false)
        .shrink_end_child(false)
        .build();
    let stack = Stack::builder().build();

    stack.add_titled(
        pages::get_task1_page().get(),
        Some("task1_page"),
        "Задание 1",
    );
    stack.add_titled(
        pages::get_task2_page().get(),
        Some("task2_page"),
        "Задание 2",
    );
    stack.add_titled(
        pages::get_task3_page().get(),
        Some("task3_page"),
        "Задание 3",
    );
    stack.add_titled(
        pages::get_task4_page().get(),
        Some("task4_page"),
        "Задание 4",
    );
    stack.add_titled(
        pages::get_task5_page().get(),
        Some("task5_page"),
        "Задание 5",
    );
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
