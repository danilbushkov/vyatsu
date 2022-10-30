mod data;
mod parse;
mod generate;
mod file;
mod hex;

use std::io;
use std::collections::{LinkedList, HashMap};
use crate::data::TBLData;
use crate::parse::parse;
use crate::generate::generate;
use crate::file::{read_file, write_file};




fn main() {

    let mut s = read_file(&"./input.txt".to_string());

    //let lines = io::stdin().lines();
    // for line in lines {
    //     s = s + &line.unwrap() + "\n";
        
    // }
    let data = parse(s);

    write_file(&"./output.txt".to_string(), &generate(&data));
    println!("{}", generate(&data));

    
    // for item in data.groups {
    //     println!("{}: {}", item.0, item.1);
    // }

    // for item in data.inputs {
    //     println!("{}", item);
    // }
    // for item in data.outputs {
    //     println!("{}", item);
    // }

    // println!("{}",data.radix);
    // println!("{}",data.unit);


}
