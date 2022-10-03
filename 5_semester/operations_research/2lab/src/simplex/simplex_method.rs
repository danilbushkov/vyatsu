
use crate::simplex::simplex_data::SimplexData;


pub fn simplex_method(data: SimplexData) -> Option<SimplexData> {
    let mut data = data;
    data.preparatory_stage();
    data.form_basis();

    let mut work = true;
    while work {
        data.calculate_deltas();
        //println!("{}", data);
        //println!("{:=>40}", "=");
        if data.check_optimality() {
            work = false;
            if data.check_artificial_variables_in_basis() {
                return None;
                //let s = "It doesn't have a correct solution because the solution contains artificial variables!";
                //println!("{}", s);
            } 
        } else {
            if !data.move_to_optimal_solution() {
                return None;
                //println!("The function is not limited. There is no optimal solution!");
                //work = false;
            }
        }
        
    }

    Some(data)
}