mod simplex_data;
mod parse;
mod input;



//use crate::simplex_data::SimplexData;
use crate::parse::parse;
use crate::input::input;


fn main() {
    let input = input();
    let mut data = parse(input);
    data.preparatory_stage();
    data.form_basis();

    let mut work = true;
    while work {
        data.calculate_deltas();
        println!("{}", data);
        println!("{:=>40}", "=");
        if data.check_optimality() {
            work = false;
            if data.check_artificial_variables_in_basis() {
                let s = "It doesn't have a correct solution because the solution contains artificial variables!";
                println!("{}", s);
            } else {
                data.print_result();
                if data.check_many_solutions() {
                    println!("Many solutions!");
                }
            }
        } else {
            if !data.move_to_optimal_solution() {
                println!("The function is not limited. There is no optimal solution!");
                work = false;
            }
        }
        
    }
    



    


}









