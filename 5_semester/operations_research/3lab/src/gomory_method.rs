pub mod simplex_data;



use crate::simplex::simplex_data::SimplexData;
use crate::simplex::simplex_method::simplex_method;
use crate::simplex::result::SimplexResult;


pub fn gomory_method(data: SimplexData) {

    let mut data = data.clone();
    let mut tmp_data = simplex_method(data.clone());

    if let Some(d) = tmp_data {
        d.print_result();
        println!("{:=>20}", "");
        let result = d.get_result();
        if !check_vec_integer(&result.vec) {
            let mut data: Option<SimplexData> = simplex_method(data); 
            let mut search = true;
            while search {
                if let Some(mut d) = data {
                    let r = d.get_result();
                    if !check_vec_integer(&r.vec) {
                        let line = get_line_max_fraciton(&d);
                        if let Some(l) = line {
                            println!("{}", d);
                            form_constraint(&mut d, l);
                            println!("{}", d);
                            data = simplex_method(d);
                        } else {
                            data = None;
                            println!("Solution does not exist");
                        }
                        
                        
                    } else {
                        if is_integer(r.f) {
                            println!("Result: ");
                            r.print();
                            
                        } else {
                            println!("Solution does not exist, F is not integer");
                        }
                        data = None;
                        search = false;
                    }
                } else {
                    println!("Solution does not exist");
                    search = false;
                }
            }



        } else {
            if is_integer(result.f) {
                println!("Integer answer");
            } else {
                println!("Solution does not exist, F is not integer");
            }
        }
    } else {
        println!("Solution does not exist");
    }

}



fn check_vec_integer(vec: &Vec<f64>) -> bool {
    for item in vec.iter() {
        if !is_integer(*item) {
            return false;
        }
    }

    true
}



fn get_line_max_fraciton(data: &SimplexData) -> Option<usize> {
    let mut max: f64 = 0.0;
    let mut index = None;
    for i in 0..data.num_of_constraints {
        let f = get_fraction(data.constraints_coefficients[i][data.num_of_vars]);
        if f > max {
            max = f;
            index = Some(i);
        } 
    }
    index
} 


fn form_constraint(data: &mut SimplexData, line: usize) -> bool {
    let right = get_fraction(data.constraints_coefficients[line][data.num_of_vars]);
    let mut left = vec![0.0; data.num_of_vars];

    for i in 0..data.num_of_vars {
        left[i] = get_fraction(data.constraints_coefficients[line][i]);
    }


    data.add_constraint(left, ">=".to_string(), right);

    false
}


fn get_fraction(f: f64) -> f64 {
    let int = f.floor();
    let res = (int - f).abs();
    if is_integer(res) {
        return 0.0;
    }
    res
}


fn is_integer(value: f64) -> bool {
    let integer = value.round();
    const EPS: f64 = 0.00000000001;
    if (value - integer).abs() < EPS {
        return true;
    }
    false
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
