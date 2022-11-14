

use crate::simulation::{simulation, sim_ch, sim_order};
use crate::binary::{f64_to_b32, b32_to_f64};






fn check_ch(project_path: &str, project_name: &str, opcode: &str, num1: f64, num2: f64, target: f64, flags: &str) {

    let (result, f) = sim_ch(project_path, project_name, opcode, num1, num2);

    assert_eq!(f,flags);
    if &f[2..3] != "1" && &f[3..4] != "1" {
        assert_eq!(format!("{:.3}",result as f32), format!("{:.3}",target as f32));
    }
    


}






#[test]
fn test_sub() {
    let pn = "project";
    let pp = "D:\\labs\\project\\";

    check_ch(pp, pn, "0", 3.0, 1.0, 2.0, "00000001");
    check_ch(pp, pn, "0", 3.0, 3.0, 0.0, "00000001");
    check_ch(pp, pn, "0", 7.323, 7.8323, 7.323-7.8323, "00000101");
    check_ch(pp, pn, "0", 3.0, -2.0, 5.0, "00000001");
    check_ch(pp, pn, "0", 3.0, -4.0, 7.0, "00000001");
    check_ch(pp, pn, "0", 3.0, -100.0, 3.0+100.0, "00000001");
    check_ch(pp, pn, "0", 3.23947234, -100.2934829034, 3.239472343+100.2934829034, "00000001");
    check_ch(pp, pn, "0", 3.0*2.0_f64.powi(30), -100.0, 3.0* 2.0_f64.powi(30)+100.0 , "00000001");
    check_ch(pp, pn, "0", -100000.0, 0.0, -100000.0 , "00000101");
    check_ch(pp, pn, "0", 0.0, -100000.0, 100000.0 , "00000001");
    check_ch(pp, pn, "0", 0.0, 100000.0, -100000.0 , "00000101");
    check_ch(pp, pn, "0", 3.0*2.0_f64.powi(21), 
    3.0*2.0_f64.powi(0), 
    3.0*2.0_f64.powi(21)-3.0*2.0_f64.powi(0), 
    "00000001");
    check_ch(pp, pn, "0", 3.0*2.0_f64.powi(23), 
    3.0*2.0_f64.powi(0), 
    3.0*2.0_f64.powi(23), 
    "00000001");
    check_ch(pp, pn, "0", 3.0*2.0_f64.powi(23), 
    3.0*2.0_f64.powi(-20), 
    3.0*2.0_f64.powi(23)-3.0*2.0_f64.powi(-20), 
    "00000001");
    check_ch(pp, pn, "0", 3.0*2.0_f64.powi(100), 
    3.0*2.0_f64.powi(70), 
    3.0*2.0_f64.powi(100), 
    "00000001");
    check_ch(pp, pn, "0", 3.0*2.0_f64.powi(-22), 
    3.0*2.0_f64.powi(22), 
    -3.0*2.0_f64.powi(22), 
    "00000101");


    check_ch(pp, pn, "0", 0.9*2.0_f64.powi(-50), 
    3.5*2.0_f64.powi(100), 
    -3.5*2.0_f64.powi(100), 
    "00000101");


    check_ch(pp, pn, "0", 0.9*2.0_f64.powi(50), 
    3.5*2.0_f64.powi(-100), 
    0.9*2.0_f64.powi(50), 
    "00000001");
    check_ch(pp, pn, "0", 0.9*2.0_f64.powi(127), 
    3.5*2.0_f64.powi(-100), 
    0.9*2.0_f64.powi(127), 
    "00000001");
}


//#[test]
// fn test_div() {
//     let pn = "project";
//     let pp = "D:\\labs\\project\\";
//     check_ch(pp, pn, "1", 0.5*2.0_f64.powi(126), 0.5*2.0_f64.powi(-1), 0.0, "00010001");
//     check_ch(pp, pn, "1", 0.5*2.0_f64.powi(126), 0.5*2.0_f64.powi(-2), 0.0, "00010001");
//     check_ch(pp, pn, "1", 0.5*2.0_f64.powi(124), 0.5*2.0_f64.powi(-2), (0.5*2.0_f64.powi(124)) / (0.5*2.0_f64.powi(-2)) , "00000001");
//     check_ch(pp, pn, "1", -5.0, 3.0, -5.0/3.0, "00000101");
//     check_ch(pp, pn, "1", -5.0, -3.0, 5.0/3.0, "00000001");
//     check_ch(pp, pn, "1", 5.0, -3.0, -5.0/3.0, "00000101");
//     check_ch(pp, pn, "1", 3.0, 1.0, 3.0, "00000001");
//     check_ch(pp, pn, "1", 100000.0, 33333.0,100000.0/33333.0, "00000001");
// }

// #[test]
// fn test_logic() {
//     let pn = "project";
//     let pp = "D:\\labs\\project\\";


// }