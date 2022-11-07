mod data;
mod parse;
mod generate;
mod file;
mod hex;
mod binary;
mod command;
mod simulation;

use std::io;
use std::collections::{LinkedList, HashMap};
use crate::data::TBLData;
use crate::parse::parse;
use crate::generate::generate;
use crate::file::{read_file, write_file};
use crate::binary::{f64_to_b32, b32_to_f64};
use crate::hex::{bin_to_hex};
use crate::command::run_simulation;
use crate::simulation::{simulation, sim_ch, sim_order};





fn main() {


    //let project_name = "lab1";
    //let project_path = "D:\\labs\\3_1_32\\";
    //D:\labs\with_my_ua
    let project_name = "project";
    let project_path = "D:\\labs\\project\\";
    
    println!("{}", sim_ch(project_path, project_name, 10.0, 5.0));
    println!("{}", sim_ch(project_path, project_name, 100.0, 10.0));
    println!("{}", sim_ch(project_path, project_name, 100.0, 5.5));
    println!("{}", sim_ch(project_path, project_name, 75.0, 3.0));

    println!("{}", sim_ch(project_path, project_name, -75.0, 3.0));
    println!("{}", sim_ch(project_path, project_name, -75.0, -3.0));

    println!("{}", sim_ch(project_path, project_name, -1.0, 1.0));
    //println!("{}", sim_ch(project_path, project_name, -1.0, -1.0));


    //println!("{}", sim_ch(project_path, project_name, 15.0, 5.0));
    //println!("{}", sim_order(project_path, project_name, 1.0, 1.0));
    //println!("{}", sim_order(project_path, project_name, 15.0, 5.0));

    // simulation(project_path, project_name, num1,
    //     num2,
    //     clk_ns,
    //     count_clk);
    //let num1 = bin_to_hex(&format!("{:032b}",f64_to_b32(10.0)));
    

    //let num2 = bin_to_hex(&format!("{:032b}",f64_to_b32(6.0)));
    

}




