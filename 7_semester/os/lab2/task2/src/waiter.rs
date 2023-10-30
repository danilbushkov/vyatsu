use crate::fork::Fork;
use std::sync::{Arc, Condvar, Mutex};

pub struct Waiter {
    forks: Mutex<Vec<Option<Arc<Fork>>>>,
    condvar: Condvar,
}

impl Waiter {
    pub fn new(forks: Vec<Option<Arc<Fork>>>) -> Self {
        Self {
            forks: Mutex::new(forks),
            condvar: Condvar::new(),
        }
    }

    pub fn take_forks(&self, forks: Vec<usize>) -> Vec<(usize, Arc<Fork>)> {
        let mut fks = self.forks.lock().unwrap();
        let mut fs = vec![];
        let mut i = 0;
        while i < forks.len() {
            while fks[forks[i]].is_none() {
                fks = self.condvar.wait(fks).unwrap();
                i = 0;
            }
            i += 1;
        }
        for i in forks.iter() {
            fs.push((*i, fks[*i].take().unwrap()));
        }
        fs
    }
    pub fn put_forks(&self, forks: Vec<(usize, Arc<Fork>)>) {
        let mut fks = self.forks.lock().unwrap();

        for (i, fk) in forks {
            fks[i] = Some(fk);
        }

        self.condvar.notify_one();
    }
}
