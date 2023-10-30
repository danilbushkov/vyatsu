use crate::fork::Fork;
use std::sync::{Arc, Condvar, Mutex};

struct Resources {
    forks: Vec<Option<Arc<Fork>>>,
    permissions: Vec<bool>,
}

pub struct Waiter {
    nps: usize,
    resources: Mutex<Resources>,
    condvar: Condvar,
}

impl Waiter {
    pub fn new(number_of_philosophers: usize, forks: Vec<Option<Arc<Fork>>>) -> Self {
        let vec = vec![true; number_of_philosophers];

        Self {
            nps: number_of_philosophers,
            resources: Mutex::new(Resources {
                forks,
                permissions: vec,
            }),
            condvar: Condvar::new(),
        }
    }

    pub fn take_forks(&self, name_philosopher: usize) -> Vec<(usize, Arc<Fork>)> {
        let mut guard = self.resources.lock().unwrap();
        let nm = name_philosopher;

        let nfks = vec![nm, (nm + 1) % self.nps];

        while !guard.permissions[nm] {
            guard = self.condvar.wait(guard).unwrap();
        }

        let mut fs = vec![];
        let mut i = 0;
        while i < nfks.len() {
            while guard.forks[nfks[i]].is_none() {
                guard = self.condvar.wait(guard).unwrap();
                i = 0;
            }
            i += 1;
        }
        for i in nfks.iter() {
            fs.push((*i, guard.forks[*i].take().unwrap()));
        }
        fs
    }
    pub fn put_forks(&self, name_philosopher: usize, forks: Vec<(usize, Arc<Fork>)>) {
        let mut guard = self.resources.lock().unwrap();
        let nm = name_philosopher;
        for (i, fk) in forks {
            guard.forks[i] = Some(fk);
        }
        let t = if nm == 0 { self.nps - 1 } else { nm - 1 };
        let neighbors = ((nm + 1) % self.nps, t);
        //guard.permissions[nm] = false;
        //guard.permissions[neighbors.0] = true;
        //guard.permissions[neighbors.1] = true;

        self.condvar.notify_one();
    }
    pub fn reset(&self) {
        let mut guard = self.resources.lock().unwrap();
        for p in guard.permissions.iter_mut() {
            *p = true;
        }
    }
}
