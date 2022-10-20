

use std::collections::{HashMap, HashSet, LinkedList};


use crate::transport_task::data::Data;



pub fn move_reserve(mut data: Data, index: (usize, usize)) -> Data {
    let cycle = get_cycle(&data.get_involved_routes(), index);
    let mut min = isize::MAX;
    
    let mut i = 1;
    while i < cycle.len() {
        if data.routes[cycle[i].0][cycle[i].1] < min {
            min = data.routes[cycle[i].0][cycle[i].1];
        }
        i += 2;
    }

    for i in 0..cycle.len() {
        if i % 2 == 0 {
            data.routes[cycle[i].0][cycle[i].1] = data.routes[cycle[i].0][cycle[i].1] + min;
        } else {
            data.routes[cycle[i].0][cycle[i].1] = data.routes[cycle[i].0][cycle[i].1] - min;
            if data.routes[cycle[i].0][cycle[i].1] == 0 
                && !data.epsilons.contains(&(cycle[i].0, cycle[i].1)) {
                
                data.involved_routes.remove(&(cycle[i].0, cycle[i].1));
            }
        }
    }

    data.involved_routes.insert(index);


    data
}


pub fn get_cycle(involved_routes: &HashMap<usize, HashSet<usize>>, 
             target: (usize, usize)) -> Vec<(usize, usize)> {

    let mut list: LinkedList<Vec<(usize, usize)>> = LinkedList::new();
    let mut results: Vec<Vec<(usize, usize)>> = vec![];
    list.push_front(vec![target]);
    
    while !list.is_empty() {
        
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