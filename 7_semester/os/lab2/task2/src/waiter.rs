use crate::fork::Fork;
use std::collections::HashSet;
use std::sync::{Arc, Condvar, Mutex};

struct Resource {
    forks: Vec<Option<Arc<Fork>>>,
    presence: HashSet<usize>,
}

pub struct Waiter {
    nps: usize,
    resource: Mutex<Resource>,
    condvar: Condvar,
}

impl Waiter {
    pub fn new(number_of_philosophers: usize, forks: Vec<Option<Arc<Fork>>>) -> Self {
        Self {
            nps: number_of_philosophers,
            resource: Mutex::new(Resource {
                forks,
                presence: HashSet::new(),
            }),
            condvar: Condvar::new(),
        }
    }

    pub fn take_forks(&self, name_philosopher: usize) -> Vec<(usize, Arc<Fork>)> {
        let mut guard = self.resource.lock().unwrap();
        let nm = name_philosopher;

        let nfks = vec![nm, (nm + 1) % self.nps];
        let t = if nm == 0 { self.nps - 1 } else { nm - 1 };
        let neighbors = ((nm + 1) % self.nps, t);

        while guard.presence.contains(&neighbors.0) || guard.presence.contains(&neighbors.1) {
            guard = self.condvar.wait(guard).unwrap();
        }
        guard.presence.insert(nm);

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
        guard.presence.remove(&nm);
        fs
    }
    pub fn put_forks(&self, _name_philosopher: usize, forks: Vec<(usize, Arc<Fork>)>) {
        let mut guard = self.resource.lock().unwrap();
        for (i, fk) in forks {
            guard.forks[i] = Some(fk);
        }

        self.condvar.notify_all();
    }
    pub fn reset(&self) {
        //
    }
}
