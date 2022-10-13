mod transport_task;


use crate::transport_task::input::input;
use crate::transport_task::parse::parse;



fn main() {

    let d = parse(input());
    println!("{}", d);

    
}
