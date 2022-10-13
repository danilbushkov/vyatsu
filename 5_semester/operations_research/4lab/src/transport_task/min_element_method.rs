

use crate::transport_task::data::Data;
use crate::transport_task::parse::parse;

pub fn min_element_method(mut data: Data) -> Data {



    data
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

    assert_eq!(min_element_method(parse(string)).routes, result);
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

    assert_eq!(min_element_method(parse(string)).routes, result);
}