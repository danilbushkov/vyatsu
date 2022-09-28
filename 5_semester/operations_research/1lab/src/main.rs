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

    println!("{}", data);


}









