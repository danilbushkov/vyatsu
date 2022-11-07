

use crate::binary::{f64_to_b32, b32_to_f64, order_b32_to_f64, order_f64_to_b32};
use crate::hex::{bin_to_hex, hex_to_bin};
use crate::data::TBLData;
use crate::parse::parse;
use crate::generate::generate;
use crate::file::{read_file, write_file};
use crate::command::run_simulation;




pub fn sim_ch(project_path: &str, project_name: &str, opcode: &str, num1: f64, num2: f64) -> (f64, String) {
    let num1 = bin_to_hex(&format!("{:032b}",f64_to_b32(num1)));
    let num2 = bin_to_hex(&format!("{:032b}",f64_to_b32(num2)));
    let data = simulation(
        project_path,
        project_name,
        &num1,
        &num2,
        25.0,
        90,
        opcode
    );
    let result = data.patterns[data.patterns.len()-2].get("result").unwrap().to_string();
    let flags = hex_to_bin(data.patterns[data.patterns.len()-2].get("F").unwrap());
    // for i in 0..data.patterns.len()-1 {
    //     let r = data.patterns[i].get("result").unwrap();
    //     let b = hex_to_bin(r);
    //     let f = b32_to_f64(u32::from_str_radix(&b, 2).unwrap());
    //     print!("{}    :"  , b);
    //     println!("{}", f);
    // } 
    //println!("{}",&hex_to_bin(&result));
    (b32_to_f64(u32::from_str_radix(&hex_to_bin(&result),2).unwrap()), flags)
}

pub fn sim_order(project_path: &str, project_name: &str,  opcode: &str, num1: f64, num2: f64) -> (f64, String) {
    let num1 = bin_to_hex(&format!("{:032b}",order_f64_to_b32(num1)));
    let num2 = bin_to_hex(&format!("{:032b}",order_f64_to_b32(num2)));
    let data = simulation(
        project_path,
        project_name,
        &num1,
        &num2,
        25.0,
        90,
        opcode
    );
    let result = data.patterns[data.patterns.len()-2].get("result").unwrap().to_string();
    let flags = hex_to_bin(data.patterns[data.patterns.len()-2].get("F").unwrap());
    
    (order_b32_to_f64(u32::from_str_radix(&hex_to_bin(&result),2).unwrap()), flags)
    
}


//hex
pub fn simulation(project_path: &str, 
    project_name: &str, 
    num1: &str,
    num2: &str,
    clk_ns: f64,
    count_clk: usize,
    opcode: &str
  ) -> TBLData {

    let tbl_file_path = project_path.to_string() + project_name + ".tbl";

    let tbl_file = read_file(&tbl_file_path);
    let data = parse(tbl_file);


    write_file(&tbl_file_path, &generate(&data, clk_ns, num1, num2, count_clk, opcode));

    run_simulation(project_path, project_name);

    let tbl_file = read_file(&tbl_file_path);
    let data = parse(tbl_file);

    
    data
}
