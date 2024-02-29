use super::widgets;
use crate::tasks;
use gtk::{Box, Orientation};

pub fn get_task1_page() -> widgets::TaskPage {
    let text_area = widgets::TextArea::new("Введите текст:");

    let text_area1 = widgets::TextArea::new("Введите текст:");

    widgets::TaskPage::new(tasks::TASK1_TEXT, text_area.get(), text_area1.get(), None)
}
