use std::collections::HashMap;


use crate::graph::Graph;


pub fn parse(mut string: String) -> Graph {
    let mut vertices: Graph = HashMap::new();
    string.retain(|c| 
        (c >= '0' && c <= '9') ||
        c == ';' ||
        c == ',' ||
        c == '-'
    );

    let parts: Vec<&str> = string.split(';').collect();
    
    let mut vec: Vec<Vec<isize>> = vec![];
    for item in parts {
        vec.push(item.split(',').map(|a| a.parse::<isize>().unwrap()).collect());
    }

    for (i, v) in vec.iter().enumerate() {
        for (j, a) in v.iter().enumerate() {
            if *a != 0 {
                if let Some(v) = vertices.get_mut(&i) {
                    v.insert(j, *a);
                } else {
                    vertices.insert(i, HashMap::from([(j, *a)]));
                }
            }
        }
    }

    vertices
}


#[test] 
fn test_parse() {
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
    
    
    
    let result: Graph = HashMap::from([
        (0, HashMap::from([(1, 5), (2, 1), (4, 2)])),
        (1, HashMap::from([(4, -1)])),
        (2, HashMap::from([(3, 2), (5, 4)])),
        (3, HashMap::from([(6, 1)])),
        (4, HashMap::from([(6, 3)])),
        (5, HashMap::from([(6, 1)])),

    ]);

    assert_eq!(parse(string), result);
}
