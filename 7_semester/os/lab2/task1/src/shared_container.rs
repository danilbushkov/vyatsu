use crate::spinlock::Spinlock;

use std::cell::UnsafeCell;

pub struct SharedContainer<T> {
    ptr: UnsafeCell<T>,
    spinlock: Spinlock,
}

impl<T> SharedContainer<T> {
    pub fn new(data: T) -> Self {
        Self {
            ptr: UnsafeCell::new(data),
            spinlock: Spinlock::new(),
        }
    }
    pub fn get_mut(&self) -> &mut T {
        self.spinlock.lock();

        unsafe { &mut *self.ptr.get() }
    }

    pub fn get(&self) -> &T {
        self.spinlock.lock();
        unsafe { &*self.ptr.get() }
    }

    pub fn unlock(&self) {
        self.spinlock.unlock();
    }
}

unsafe impl<T> Sync for SharedContainer<T> {}
