mod task1;
mod task2;
mod task3;
mod task4;
mod task5;

use std::collections::HashSet;
pub use task1::get_task1_page;
pub use task2::get_task2_page;
pub use task3::get_task3_page;
pub use task4::get_task4_page;
pub use task5::get_task5_page;

pub fn check_str(text: &str, valid_chars: &HashSet<char>) -> Result<(), String> {
    for ch in text.chars() {
        if !valid_chars.contains(&ch) {
            return Err(format!("Введен некорректный символ: {}", ch));
        }
    }

    Ok(())
}
