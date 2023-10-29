use eframe::egui::mutex::{Mutex, MutexGuard};
use eframe::egui::Pos2;

#[derive(Copy, Clone)]
pub enum State {
    Eat,
    Hungry,
    Sleep,
}

pub struct Philosopher {
    pos: Pos2,
    left_fork: Mutex<bool>,
    right_fork: Mutex<bool>,
    state: Mutex<State>,
    number_of_eaten_portions: Mutex<usize>,
    frequency: Mutex<usize>,
}

impl Philosopher {
    pub fn new(pos: Pos2) -> Self {
        Self {
            pos,
            ..Self::default()
        }
    }
    pub fn get_mut_frequency(&self) -> MutexGuard<'_, usize> {
        self.frequency.lock()
    }
    pub fn get_frequency(&self) -> usize {
        *self.frequency.lock()
    }
    pub fn get_pos(&self) -> Pos2 {
        self.pos
    }
    pub fn set_left_fork(&self, value: bool) {
        *self.left_fork.lock() = value;
    }
    pub fn get_left_fork(&self) -> bool {
        *self.left_fork.lock()
    }
    pub fn set_right_fork(&self, value: bool) {
        *self.right_fork.lock() = value;
    }
    pub fn get_right_fork(&self) -> bool {
        *self.right_fork.lock()
    }
    pub fn get_state(&self) -> State {
        *self.state.lock()
    }
    pub fn set_state(&self, state: State) {
        *self.state.lock() = state;
    }
    pub fn inc_number_of_eaten_portions(&self) {
        *self.number_of_eaten_portions.lock() += 1;
    }
    pub fn get_number_of_eaten_portions(&self) -> usize {
        *self.number_of_eaten_portions.lock()
    }
}

impl Default for Philosopher {
    fn default() -> Self {
        Self {
            pos: eframe::egui::pos2(0.0, 0.0),
            left_fork: Mutex::new(false),
            right_fork: Mutex::new(false),
            state: Mutex::new(State::Sleep),
            number_of_eaten_portions: Mutex::new(0),
            frequency: Mutex::new(0),
        }
    }
}
