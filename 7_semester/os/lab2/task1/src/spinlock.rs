use std::hint;
use std::sync::atomic::{AtomicUsize, Ordering};

pub struct Spinlock {
    atomic: AtomicUsize,
}

impl Spinlock {
    pub fn new() -> Self {
        Self {
            atomic: AtomicUsize::new(0),
        }
    }
    pub fn lock(&self) {
        while self
            .atomic
            .compare_exchange(0, 1, Ordering::SeqCst, Ordering::SeqCst)
            .is_err()
        {
            hint::spin_loop();
        }
    }

    pub fn unlock(&self) {
        self.atomic.store(0, Ordering::SeqCst);
    }
}
