

use std::collections::{LinkedList, HashMap};

use crate::graph::Graph;
use crate::graph::parse;



pub fn find_shortcut(graph: &Graph, start: usize, target: usize) -> (Vec<usize>, isize) {
    let mut list: LinkedList<usize> = LinkedList::new();
    match graph.get(&start) {
        Some(v) => {
            for item in v {
                list.push_front(*item.0);
            }
        }
        None => {
            return (vec![], 0);
        }
    }

    let mut road = vec![];
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
                            if (*cost + value) < min {
                                min = *cost + value;
                            }
                        } else {
                            not_calculated.push(*a);
                        }
                    }
                }
                if not_calculated.len() == 0 {
                    if min == isize::MAX {
                        vertices_costs.insert(vertice, 0);
                    } else {
                        vertices_costs.insert(vertice, min);
                        if vertice != target {
                            if let Some(vertices) = graph.get(&vertice) {
                                for item in vertices {
                                    list.push_front(*item.0);
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

    (road, cost)
}



#[test]
fn test_find_shortcut() {
    let string = "
            a   b   c   d   e   f   g 
        a   0,  5,  1,  0,  2,  0,  0 ;
        b   0,  0,  0,  0, -1,  0,  0 ;
        c   0,  0,  0,  2,  0,  4,  0 ;
        d   0,  0,  0,  0,  0,  0,  1 ;
        e   0,  0,  0,  0,  0,  0,  3 ;
        f   0,  0,  0,  0,  0,  0,  1 ;
        g   0,  0,  0,  0,  0,  0,  0 
    ".to_string();



    let result: Vec<usize> = vec![2, 3];

    assert_eq!(find_shortcut(&parse(string), 0, 6), (result, 4))
}







