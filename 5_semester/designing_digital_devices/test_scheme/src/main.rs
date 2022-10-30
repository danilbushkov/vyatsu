mod data;
mod parse;
mod generate;
mod file;
mod hex;
mod binary;

use std::io;
use std::collections::{LinkedList, HashMap};
use crate::data::TBLData;
use crate::parse::parse;
use crate::generate::generate;
use crate::file::{read_file, write_file};
use crate::binary::{f64_to_b32, b32_to_f64};
use crate::hex::{bin_to_hex};




fn main() {

    let mut s = read_file(&"./input.txt".to_string());

    //let lines = io::stdin().lines();
    // for line in lines {
    //     s = s + &line.unwrap() + "\n";
        
    // }
    let data = parse(s);
    //
    //100_0001_1110_0000_0000_0000_0000_0000
    //write_file(&"./output.txt".to_string(), &generate(&data));
    let num1 = bin_to_hex(&format!("{:032b}",f64_to_b32(10.0)));
    //println!("{:032b}", f64_to_b32(10.0));
    //println!("{:032b}", f64_to_b32(6.0));
    let num2 = bin_to_hex(&format!("{:032b}",f64_to_b32(6.0)));
    println!("{}", generate(&data, 25.0, &num1, &num2));

    
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
