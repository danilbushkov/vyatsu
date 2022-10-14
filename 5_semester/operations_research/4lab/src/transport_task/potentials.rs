

use std::collections::HashSet;




pub fn get_negative_cell(costs: &Vec<Vec<isize>>, involved_routes: &HashSet<(usize, usize)>) -> Option<(usize, usize)> {
    let mut evaluations = get_evaluations(costs, involved_routes);

    for item in evaluations {
        if item.2 < 0 {
            return Some((item.0, item.1));
        }
    }
    None
}



fn get_evaluations(costs: &Vec<Vec<isize>>, involved_routes: &HashSet<(usize, usize)>) -> Vec<(usize, usize, isize)> {
    let (reserves, needs) = get_potentials(costs, involved_routes);

    let mut set: &HashSet<(usize, usize)> = involved_routes;
    

    let mut not_involved_routes = vec![];
    for i in 0..costs.len() {
        for j in 0..costs[0].len() {
            if !set.contains(&(i, j)) {
                not_involved_routes.push((i, j, 0));
            }
        }
    }

    for item in not_involved_routes.iter_mut() {
        item.2 = costs[item.0][item.1] - (reserves[item.0] + needs[item.1]);
    }


    not_involved_routes
}


pub fn get_potentials(costs: &Vec<Vec<isize>>, involved_routes: &HashSet<(usize, usize)>) -> (Vec<isize>, Vec<isize>) {
    let mut needs: Vec<Option<isize>> = vec![None; costs[0].len()];
    let mut reserves: Vec<Option<isize>> = vec![None; costs.len()];


    reserves[0] = Some(0);

    let mut i = 0;
    let mut len = needs.len() + reserves.len()-1;
    while i < len {
        
        for (a, b) in involved_routes {

            match needs[*b] {
                Some(p) => {
                    if let None = reserves[*a] {
                        reserves[*a] = Some(costs[*a][*b] - p);
                        i += 1;
                    }   
                },
                None => {
                    if let Some(p) = reserves[*a] {
                        needs[*b] = Some(costs[*a][*b] - p);
                        i += 1;
                    }
                }
            }

            

        }
    }

    let needs: Vec<isize> = needs.iter().map(|a| a.unwrap()).collect();
    let reserves: Vec<isize> = reserves.iter().map(|a| a.unwrap()).collect();


    (reserves, needs)
}




#[test]
fn test_get_evaluations() {
    let costs: Vec<Vec<isize>> = vec![
        vec![3, 5, 4, 0],
        vec![6, 3, 1, 0],
        vec![3, 2, 7, 0],
    ];

    let involved_routes: HashSet<(usize, usize)> = HashSet::from([
        (0, 0),
        (1, 0),
        (1, 1),
        (1, 2),
        (1, 3),
        (2, 1),
    ]);

    let results = vec![
        (0, 1, 5),
        (0, 2, 6),
        (0, 3, 3),
        (2, 0, -2),
        (2, 2, 7),
        (2, 3, 1),
    ];

    assert_eq!(get_evaluations(&costs, &involved_routes), results);
}




#[test]
fn test_get_potentials_0() {
    let costs: Vec<Vec<isize>> = vec![
        vec![4, 5, 3, 6],
        vec![7, 2, 1, 5],
        vec![6, 1, 4, 2],
        vec![0, 0, 0, 0]
    ];

    let involved_routes: HashSet<(usize, usize)> = HashSet::from([
        (0, 0),
        (0, 2),
        (0, 3),
        (1, 2),
        (2, 1),
        (2, 3),
        (3, 3),
    ]);

    let results = (vec![0, -2, -4, -6], vec![4, 5, 3, 6]);

    assert_eq!(get_potentials(&costs, &involved_routes), results);
}


#[test]
fn test_get_potentials_1() {
    let costs: Vec<Vec<isize>> = vec![
        vec![4, 5, 3, 6],
        vec![7, 2, 1, 5],
        vec![6, 1, 4, 2],
        vec![0, 0, 0, 0]
    ];

    let involved_routes: HashSet<(usize, usize)> = HashSet::from([
        (0, 0),
        (0, 2),
        (1, 1),
        (1, 2),
        (2, 1),
        (2, 3),
        (3, 3),
    ]);

    let results = (vec![0, -2, -3, -5], vec![4, 4, 3, 5]);

    assert_eq!(get_potentials(&costs, &involved_routes), results);
}