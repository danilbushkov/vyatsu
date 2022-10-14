

use std::collections::{HashMap, HashSet, LinkedList};


use crate::transport_task::data::Data;



pub fn move_reserve(mut data: Data, index: (usize, usize)) -> Data {
    data.get_involved_routes();


    data
}


pub fn get_cycle(involved_routes: &HashMap<usize, HashSet<usize>>, 
             target: (usize, usize)) -> Vec<(usize, usize)> {

    let mut list: LinkedList<Vec<(usize, usize)>> = LinkedList::new();
    let mut results: Vec<Vec<(usize, usize)>> = vec![];
    list.push_front(vec![target]);
    let mut c = 0;
    while !list.is_empty() && c < 30 {
        c += 1;
        if let Some(v) = list.pop_back() {
            if v.len() % 2 == 1 {

                if let Some(l) = v.last() {
                    if let Some(s) = involved_routes.get(&l.0) {
                        for item in s {
                            if *item != l.1 {
                                let mut vec = v.clone();
                                vec.push((l.0, *item));
                                list.push_front(vec);
                            }
                        }
                    }
                } 

            } else {
                if let Some(l) = v.last() {
                    if l.1 == target.1 {
                        results.push(v);
                    }else {
                        if let Some(l) = v.last() {
                            for (a, set) in involved_routes.iter() {
                                if set.contains(&l.1) && *a != l.0 {
                                    let mut vec = v.clone();
                                    vec.push((*a, l.1));
                                    list.push_front(vec);
                                    
                                }
                            }
                        }
                    }
                } 
            }
        }
    }
    if !results.is_empty() {
        return results[0].clone();
    }
    vec![]
}


#[test]
fn test_get_cycle() {
    let cycle = get_cycle(&HashMap::from(
        [
            (0, HashSet::from([0, 2, 3])),
            (1, HashSet::from([2])),
            (2, HashSet::from([1, 3])),
            (3, HashSet::from([3])),
        ]
    ), (1, 1));
    let result: Vec<(usize, usize)> = vec![
        (1, 1),
        (1, 2),
        (0, 2),
        (0, 3),
        (2, 3),
        (2, 1),

    ];

    assert_eq!(cycle, result);
}