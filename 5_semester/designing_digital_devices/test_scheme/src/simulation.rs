

use crate::binary::{f64_to_b32, b32_to_f64};
use crate::hex::{bin_to_hex, hex_to_bin};
use crate::data::TBLData;
use crate::parse::parse;
use crate::generate::generate;
use crate::file::{read_file, write_file};
use crate::command::run_simulation;

pub fn sim_ch(project_path: &str, project_name: &str, num1: f64, num2: f64) -> f64 {
    let num1 = bin_to_hex(&format!("{:032b}",f64_to_b32(num1)));
    let num2 = bin_to_hex(&format!("{:032b}",f64_to_b32(num2)));
    let result = simulation(
        project_path,
        project_name,
        &num1,
        &num2,
        25.0,
        70
    );

    b32_to_f64(u32::from_str_radix(&hex_to_bin(&result),2).unwrap())
    
}


//hex
pub fn simulation(project_path: &str, 
    project_name: &str, 
    num1: &str,
    num2: &str,
    clk_ns: f64,
    count_clk: usize,
  ) -> String {

    let tbl_file_path = project_path.to_string() + project_name + ".tbl";

    let tbl_file = read_file(&tbl_file_path);
    let data = parse(tbl_file);


    write_file(&tbl_file_path, &generate(&data, clk_ns, num1, num2, count_clk));

    run_simulation(project_path, project_name);

    let tbl_file = read_file(&tbl_file_path);
    let data = parse(tbl_file);

    data.patterns[data.patterns.len()-2].get("result").unwrap().to_string()
}
