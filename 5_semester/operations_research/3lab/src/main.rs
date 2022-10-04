mod simplex;
mod branch;
mod parse;
mod input;
mod gomory_method;



//use crate::simplex_data::SimplexData;
use crate::parse::parse;
use crate::input::input;
//use crate::branch::branch_and_bound_method;
use crate::gomory_method::gomory_method;


fn main() {
    let input = input();
    let mut data = parse(input);
    
    //branch_and_bound_method(data);
    gomory_method(data);


    


}








