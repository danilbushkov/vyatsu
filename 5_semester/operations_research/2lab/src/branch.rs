
use std::collections::LinkedList;

use crate::simplex::simplex_data::SimplexData;
use crate::simplex::simplex_method::simplex_method;
use crate::simplex::result::SimplexResult;


pub fn branch_and_bound_method(data: SimplexData) {
    let mut data = data.clone();
    let mut tmp_data = simplex_method(data.clone());
    if let Some(d) = tmp_data {
        d.print_result();
        println!("{:=>9}", "=");
        let result = d.get_result();

        let mut int_results: Vec<SimplexResult> = vec![];
        let mut list: LinkedList<SimplexData> = LinkedList::new();
        list.push_front(data);

        if !check_vec_integer(&d.get_result().vec) {
            while !list.is_empty() {
                
                let data = list.pop_back().unwrap();
                //println!("{}", data);
                let mut data_left = data.clone();
                let mut data_right = data.clone();
                
                let result = simplex_method(data);
                if let Some(r) = result {
                    r.get_result().print();
                    
                    println!("{:->9}", "-");
                    if check_result_for_integer(&r.get_result()) {
                        int_results.push(r.get_result());
                    } else {
                        let vec = get_non_integer_value(&r.get_result());
                        if !vec.is_empty() {
                            
                            let i = vec[0].0;
                            let v = vec[0].1;

                            //for (i, v) in vec {
                                let mut l = data_left.clone();
                                let mut r = data_right.clone();
                                l.add_condition(i, "<=".to_string(), v.floor());
                                r.add_condition(i, ">=".to_string(), v.ceil());
                                println!("{}", l);
                                println!("{}", r);
                                list.push_front(l);
                                list.push_front(r);
                            //}
                            
                        } else {
                            println!("{}", "Branch has no solution");
                            println!("{:->9}", "-");
                        }
                    }
                } else {

                    println!("{}", "Branch has no solution");
                    println!("{:->9}", "-");
                }
            }

            if let Some(r) = find_the_best_solution(d.get_result().f, int_results) {
                println!("Result:");
                r.print();
            } else {
                println!("Result:");
                println!("{}", "Branch has no solution");
            }

        } else {
            println!("Solution does not exist");
        }



    } else {
        println!("Solution does not exist");
    }
    
    
}


fn find_the_best_solution(target: f64, vec: Vec<SimplexResult>) -> Option<SimplexResult> {
    let mut result: Option<SimplexResult> = None;

    let mut min = f64::MAX;

    for item in vec {
        if (target - item.f).abs() < min {
            min = (target - item.f).abs();
            result = Some(item);
        }
    }

    result
}



fn check_vec_integer(vec: &Vec<f64>) -> bool {
    for item in vec.iter() {
        if !is_integer(*item) {
            return false;
        }
    }

    true
}


fn check_result_for_integer(result: &SimplexResult) -> bool {

    for item in result.vec.iter() {
        if !is_integer(*item) {
            return false;
        }
    }

    if !is_integer(result.f) {
        return false;
    }

    true
}

fn get_non_integer_value(r: &SimplexResult) -> Vec<(usize, f64)> {
    let mut result = vec![];
    for (i, item) in r.vec.iter().enumerate() {
        if !is_integer(*item) {
            result.push((i,*item));
            
        }
    }
    result
}



fn is_integer(value: f64) -> bool {
    let integer = value.round();
    const EPS: f64 = 0.00000000001;
    if (value - integer).abs() < EPS {
        return true;
    }
    false
}