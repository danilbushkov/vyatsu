

use std::collections::HashSet;

use crate::transport_task::data::Data;
use crate::transport_task::parse::parse;

pub fn min_element_method(mut data: Data) -> Data {
    let mut sorted_costs = get_sorted_cost(&data.costs);

    let difference = data.get_amount_reserves() - data.get_amount_needs();
    if difference > 0 {
        data.add_fictitious_need(difference);
        for i in 0..data.number_of_providers {
            sorted_costs.push((i, data.number_of_clients, 0));
        }
    } else if difference < 0 {
        data.add_fictitious_reserve(difference.abs());
        for j in 0..data.number_of_clients {
            sorted_costs.push((data.number_of_providers, j, 0));
        }
    }
    

    let mut reserves = data.reserves.clone();
    let mut needs = data.needs.clone();

    let mut possible_reserves: HashSet<usize> = HashSet::new();
    let mut possible_needs: HashSet<usize> = HashSet::new();
    let mut reserve = false;
    let mut i: usize = 0;
    while i < sorted_costs.len() {

        if ( 
            ((reserves[sorted_costs[i].0] > 0)
            && (reserves[sorted_costs[i].0] <= needs[sorted_costs[i].1]))) 

            || ( possible_reserves.contains(&sorted_costs[i].0) && 
               ( possible_needs.contains(&sorted_costs[i].1) || needs[sorted_costs[i].1] > 0) ) {


            if possible_reserves.contains(&sorted_costs[i].0) {
                data.epsilons.push((sorted_costs[i].0, sorted_costs[i].1));
                possible_reserves.remove(&sorted_costs[i].0);
                if possible_needs.contains(&sorted_costs[i].1) {
                    possible_needs.remove(&sorted_costs[i].1);
                }
            }

            if (reserves[sorted_costs[i].0] == needs[sorted_costs[i].1]) 
                && reserves[sorted_costs[i].0] > 0 {
                if reserve {
                    possible_reserves.insert(sorted_costs[i].0);
                    reserve = false;
                } else {
                    possible_needs.insert(sorted_costs[i].1);
                    reserve = true;
                }
            }

            data.routes[sorted_costs[i].0][sorted_costs[i].1] = reserves[sorted_costs[i].0];
            needs[sorted_costs[i].1] -= reserves[sorted_costs[i].0];
            reserves[sorted_costs[i].0] = 0;
            data.involved_routes.insert((sorted_costs[i].0, sorted_costs[i].1));

            

            

        } else if 
            ( (needs[sorted_costs[i].1] > 0) 
            && (reserves[sorted_costs[i].0] >= needs[sorted_costs[i].1]))
            
            || ( possible_needs.contains(&sorted_costs[i].1) &&
                (possible_reserves.contains(&sorted_costs[i].0) || reserves[sorted_costs[i].0] > 0)) {


            if possible_needs.contains(&sorted_costs[i].1) {
                data.epsilons.push((sorted_costs[i].0, sorted_costs[i].1));
                possible_needs.remove(&sorted_costs[i].1);
                if possible_reserves.contains(&sorted_costs[i].0) {
                    possible_reserves.remove(&sorted_costs[i].0);
                }
            }


            if (reserves[sorted_costs[i].0] == needs[sorted_costs[i].1]) 
                && reserves[sorted_costs[i].0] > 0 {
            
                if reserve {
                    possible_reserves.insert(sorted_costs[i].0);
                    reserve = false;
                } else {
                    possible_needs.insert(sorted_costs[i].1);
                    reserve = true;
                }
                
            }


            data.routes[sorted_costs[i].0][sorted_costs[i].1] = needs[sorted_costs[i].1];
            reserves[sorted_costs[i].0] -= needs[sorted_costs[i].1];
            needs[sorted_costs[i].1] = 0;
            data.involved_routes.insert((sorted_costs[i].0, sorted_costs[i].1));

            

        }
        
        
        i += 1;
        
        
    }
    
    println!("{}", data);
    data
}

fn get_amount(vec: &Vec<isize>) -> isize {
    let mut amount = 0;
    for item in vec {
        amount += item;
    }
    amount
}

fn get_sorted_cost(costs: &Vec<Vec<isize>>) -> Vec<(usize, usize, isize)> {
    let mut result: Vec<(usize, usize, isize)> = vec![];
    for (i, vec) in costs.iter().enumerate() {
        for (j, item) in vec.iter().enumerate() {
            result.push((i, j, *item));
        }  
    }
    result.sort_by(|a, b| (a.2).partial_cmp(&b.2).unwrap());
    result
}




#[test]
fn test_min_el_method_0() {
    let string = "
        Reserves: 10, 20, 30 ;
        Needs: 15, 20, 25 ;
        Costs(a/b):
        5, 3, 1,
        3, 2, 4,
        4, 1, 2
    
        end
    ".to_string();
    
    let result = vec![
        vec![0, 0, 10],
        vec![15, 0, 5],
        vec![0, 20, 10],
    ];

    assert_eq!(min_element_method(parse(string.clone())).routes, result);
    assert_eq!(min_element_method(parse(string)).involved_routes, HashSet::from([
        (0, 2),
        (2, 1),
        (2, 2),
        (1, 0),
        (1, 2),
    ]));
}



#[test]
fn test_min_el_method_1() {
    let string = "
        Reserves: 20, 40, 30 ;
        Needs: 30, 35, 20 ;
        Costs(a/b):
        3, 5, 4,
        6, 3, 1,
        3, 2, 7
    
        end
    ".to_string();
    
    let result = vec![
        vec![20, 0, 0, 0],
        vec![10, 5, 20, 5],
        vec![0, 30, 0, 0],
    ];

    assert_eq!(min_element_method(parse(string.clone())).routes, result);
    assert_eq!(min_element_method(parse(string.clone())).epsilons, vec![]);
}

#[test]
fn test_min_el_method_2() {
    let string = "
        Reserves: 30, 25, 20 ;
        Needs: 20, 15, 25, 20 ;
        Costs(a/b):
        4, 5, 3, 6,
        7, 2, 1, 5,
        6, 1, 4, 2
    
        end
    ".to_string();
    
    let result = vec![
        vec![20, 0, 0, 10],
        vec![0, 0, 25, 0],
        vec![0, 15, 0, 5],
        vec![0, 0, 0, 5],
    ];

    assert_eq!(min_element_method(parse(string.clone())).routes, result);
    assert_eq!(min_element_method(parse(string.clone())).involved_routes, HashSet::from([
        (1, 2),
        (2, 1),
        (2, 3),
        (0, 2),
        (0, 0),
        (0, 3),
        (3, 3),
    ]));
    assert_eq!(min_element_method(parse(string.clone())).epsilons, vec![
        (0, 2),
    ]);
}


#[test]
fn test_min_el_method_3() {
    let string = "
        Reserves: 160, 120, 170 ;
        Needs: 120, 50, 190, 90 ;
        Costs(a/b):
        7, 8, 1, 2,
        4, 5, 9, 8,
        9, 2, 3, 6
    
        end
    ".to_string();
    
    let result = vec![
        vec![0, 0, 160, 0],
        vec![120, 0, 0, 0],
        vec![0, 50, 30, 90],
    ];

    assert_eq!(min_element_method(parse(string.clone())).routes, result);
    assert_eq!(min_element_method(parse(string.clone())).involved_routes, HashSet::from([
        (0, 2),
        (2, 1),
        (2, 2),
        (1, 0),
        (2, 3),
        (2, 0),
    ]));
    assert_eq!(min_element_method(parse(string.clone())).epsilons, vec![
        (2, 0),
    ]);

}