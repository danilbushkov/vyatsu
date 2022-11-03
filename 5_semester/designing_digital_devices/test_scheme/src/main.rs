mod data;
mod parse;
mod generate;
mod file;
mod hex;
mod binary;
mod command;

use std::io;
use std::collections::{LinkedList, HashMap};
use crate::data::TBLData;
use crate::parse::parse;
use crate::generate::generate;
use crate::file::{read_file, write_file};
use crate::binary::{f64_to_b32, b32_to_f64};
use crate::hex::{bin_to_hex};
use crate::command::run_simulation;





fn main() {


    let project_name = "lab1";
    let project_path = "D:\\labs\\3_1_32\\";
    let tbl_file_path = project_path.to_string() + project_name + ".tbl";
    let tbl_file = read_file(&tbl_file_path);

    let data = parse(tbl_file);

    //run_simulation(project_path, project_name);

    
    let num1 = bin_to_hex(&format!("{:032b}",f64_to_b32(10.0)));
    

    let num2 = bin_to_hex(&format!("{:032b}",f64_to_b32(6.0)));
    write_file(&tbl_file_path, &generate(&data, 25.0, &num1, &num2, 70));
    
    run_simulation(project_path, project_name);

    //println!("{}", args);
    

    //println!("{}", output.stdout.as_slice().escape_ascii().to_string());

    //let mut s = read_file(&"./input.txt".to_string());

    

    //let data = parse(s);
    

    //let num1 = bin_to_hex(&format!("{:032b}",f64_to_b32(10.0)));
    

    //let num2 = bin_to_hex(&format!("{:032b}",f64_to_b32(6.0)));
    //println!("{}", generate(&data, 25.0, &num1, &num2));


    //let lines = io::stdin().lines();
    // for line in lines {
    //     s = s + &line.unwrap() + "\n";
        
    // }
    //
    //100_0001_1110_0000_0000_0000_0000_0000
    //write_file(&"./output.txt".to_string(), &generate(&data));
    //println!("{:032b}", f64_to_b32(10.0));
    //println!("{:032b}", f64_to_b32(6.0));
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
