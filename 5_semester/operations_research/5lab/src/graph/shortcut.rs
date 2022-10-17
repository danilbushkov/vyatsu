

use std::collections::{LinkedList, HashMap};

use crate::graph::Edges;
use crate::graph::parse;



pub fn find_shortcut(graph: &Edges, start: usize, target: usize) -> (LinkedList<usize>, isize) {
    let mut list: LinkedList<usize> = LinkedList::new();
    match graph.get(&start) {
        Some(v) => {
            for item in v {
                list.push_front(*item.0);
            }
        }
        None => {
            return (LinkedList::new(), 0);
        }
    }

    let mut road = LinkedList::new();
    let mut vertices_costs: HashMap<usize, isize> = HashMap::new();
    vertices_costs.insert(start, 0);
    
    
    
    while !list.is_empty() {
        if let Some(vertice) = list.pop_back() {
            
            if !vertices_costs.contains_key(&vertice) {
                let mut not_calculated: Vec<usize> = vec![];
                let mut min = isize::MAX;
                for (a, b) in graph {
                    
                    if let Some(value) = b.get(&vertice) {
                        if let Some(cost) = vertices_costs.get(&a) {

                            if (*cost + value) < min && *a != vertice {
                                min = *cost + value;
                            }
                        } else {
                            not_calculated.push(*a);
                        }
                    }
                    
                }
                if not_calculated.len() == 0 {
                    if min == isize::MAX {
                        vertices_costs.insert(vertice, isize::MAX);
                    } else {
                        vertices_costs.insert(vertice, min);
                        if vertice != target {
                            if let Some(vertices) = graph.get(&vertice) {
                                for item in vertices {
                                    if !vertices_costs.contains_key(item.0) {
                                        list.push_front(*item.0);
                                    }
                                }
                            }
                        }
                    }
                } else {
                    list.push_back(vertice);
                    for item in not_calculated {
                        list.push_back(item);
                    }
                }
            }
        }
    }




    let mut cost = 0;
    if let Some(c) = vertices_costs.get(&target) {
        cost = *c;
    }

    if cost != 0 { 
        let mut ct = cost;
        let mut v = target;
        road.push_back(v);
        while ct != 0 {
            let c = ct;
            for (key, value) in graph {
                if let Some(a) = value.get(&v) {
                    if let Some(t) = vertices_costs.get(&key) {
                        if (c-a) == *t {
                            v = *key;
                            ct = c-a;
                        }
                    }
                    
                }
            }
            road.push_front(v);
        }
    }

    
    

    (road, cost)
}



#[test]
fn test_find_shortcut_0() {
    let string = "
            a   b   c   d   e   f   g 
        a   1,  5,  1,  0,  2,  0,  0 ;
        b   0,  0,  0,  0, -1,  0,  0 ;
        c   0,  0,  0,  2,  0,  4,  0 ;
        d   0,  0,  0,  0,  0,  0,  1 ;
        e   0,  0,  0,  0,  0,  0,  3 ;
        f   0,  0,  0,  0,  0,  0,  1 ;
        g   0,  0,  0,  0,  0,  0,  0 
    ".to_string();



    let result: LinkedList<usize> = LinkedList::from([0, 2, 3, 6]);

    assert_eq!(find_shortcut(&parse(string).edges, 0, 6), (result, 4))
}


#[test]
fn test_find_shortcut_1() {
    let string = "
            a   b   c   d   e   f   g   h   i   j   k
        a   1,  5,  1,  0,  2,  0,  0, -5,  0,  0,  0;
        b   0,  0,  0,  0, -1,  0,  0,  0,  0,  0,  0;
        c   0,  0,  0,  2,  0,  4,  0,  0,  0,  0,  0;
        d   0,  0,  0,  0,  0,  0,  1,  0,  0,  0,  0;
        e   0,  0,  0,  0,  0,  0,  3,  0,  0,  0,  3;
        f   0,  0,  0,  0,  0,  0,  1,  0,  0,  0,  0;
        g   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0;
        h   0, -3,  0,  0,  0,  0,  0,  0,  0,  0,  0;
        i   0,  0, -3,  0,  0,  0,  0,  0,  0,  3,  0;
        j   0,  0,  0,  0,  0,  5,  0,  0,  0,  0,  0;
        k   0,  0,  0,  0,  0,  0,  2,  0,  0,  0,  0
    ".to_string();



    let result: LinkedList<usize> = LinkedList::from([0, 7, 1, 4, 6]);

    assert_eq!(find_shortcut(&parse(string).edges, 0, 6), (result, -6))
}


#[test]
fn test_find_shortcut_2() {
    let string = "
            a   b   c   d   e   f   g   h
        a   1,  5,  1,  0,  2,  0,  0,  0;
        b   0,  0,  0,  0, -1,  0,  0,  0;
        c   0,  0,  0,  2,  0,  4,  0,  2;
        d   2,  0,  0,  0,  0,  0,  1,  0;
        e   0,  0,  0,  0,  0,  0,  3,  0;
        f   0,  0,  0,  0,  0,  0,  1,  0;
        g   0,  0,  0,  0,  0,  0,  0,  0;
        h  -1,  0,  0,  0,  0,  0,  0,  0
    ".to_string();



    let result: LinkedList<usize> = LinkedList::from([0, 2, 3, 6]);

    assert_eq!(find_shortcut(&parse(string).edges, 0, 6), (result, 4))
}





