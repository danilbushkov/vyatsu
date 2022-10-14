pub mod data;
pub mod parse;
pub mod input;
pub mod display;
mod min_element_method;
mod potentials;
pub mod potential_method;


use crate::transport_task::parse::parse;
use crate::transport_task::data::Data;
use crate::transport_task::min_element_method::min_element_method;
use crate::transport_task::potentials::get_negative_cell;
use crate::transport_task::potential_method::move_reserve;



pub fn transport_task(mut data: Data) -> isize {
    let mut data = min_element_method(data);

    while let Some(index) = get_negative_cell(&data.costs, &data.involved_routes) {
        data = move_reserve(data, index);
    }



    data.get_result()
}


#[test]
fn test_transport_task_0() {
    let string = "
        Reserves: 160, 120, 170 ;
        Needs: 120, 50, 190, 90 ;
        Costs(a/b):
        7, 8, 1, 2,
        4, 5, 9, 8,
        9, 2, 3, 6
    
        end
    ".to_string();
    
        
    assert_eq!(transport_task(parse(string)), 1190);

    
}
#[test]
fn test_transport_task_1() {
    let string = "
        Reserves: 1, 2, 3, 5 ;
        Needs: 10, 4, 1 ;
        Costs(a/b):
        1, 2, 3,
        5, 6, 7,
        8, 9, 10,
        1, 1, 1
    
        end
    ".to_string();
    
        
    assert_eq!(transport_task(parse(string)), 40);

    
}
#[test]
fn test_transport_task_2() {
    let string = "
        Reserves: 10, 20, 30 ;
        Needs: 15, 20, 25 ;
        Costs(a/b):
        5, 3, 1,
        3, 2, 4,
        4, 1, 2
    
        end
    ".to_string();
    
        
    assert_eq!(transport_task(parse(string)), 110);

    
}
#[test]
fn test_transport_task_3() {
    let string = "
        Reserves: 20, 40, 30 ;
        Needs: 30, 35, 20 ;
        Costs(a/b):
        3, 5, 4,
        6, 3, 1,
        3, 2, 7

        end
    ".to_string();
    
        
    assert_eq!(transport_task(parse(string)), 195);

    
}
#[test]
fn test_transport_task_4() {
    let string = "
        Reserves: 30, 25, 20 ;
        Needs: 20, 15, 25, 20 ;
        Costs(a/b):
        4, 5, 3, 6,
        7, 2, 1, 5,
        6, 1, 4, 2
    
        end
    ".to_string();
    
        
    assert_eq!(transport_task(parse(string)), 180);

    
}

#[test]
fn test_transport_task_5() {
    let string = "
        Reserves: 10, 20, 30 ;
        Needs: 15, 20, 25 ;
        Costs(a/b):
        5, 3, 1, 
        3, 2, 4, 
        4, 1, 2
    
        end
    ".to_string();
    
        
    assert_eq!(transport_task(parse(string)), 110);

    
}

#[test]
fn test_transport_task_6() {
    let string = "
        Reserves: 30, 25, 20 ;
        Needs: 20, 15, 25, 20 ;
        Costs(a/b):
        4, 5, 3, 6, 
        7, 2, 1, 5,
        6, 1, 4, 2
    
        end
    ".to_string();
    
        
    assert_eq!(transport_task(parse(string)), 180);

    
}


#[test]
fn test_transport_task_7() {
    let string = "
        Reserves: 20, 40, 30 ;
        Needs: 30, 35, 20 ;
        Costs(a/b):
        3, 5, 4,
        6, 3, 1,
        3, 2, 7
    
        end
    ".to_string();
    
        
    assert_eq!(transport_task(parse(string)), 195);

    
}
