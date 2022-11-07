

use crate::simulation::{simulation, sim_ch, sim_order};
use crate::binary::{f64_to_b32, b32_to_f64};






fn check_ch(project_path: &str, project_name: &str, opcode: &str, num1: f64, num2: f64, target: f64, flags: &str) {

    let (result, f) = sim_ch(project_path, project_name, opcode, num1, num2);

    assert_eq!(format!("{:.3}",result as f32), format!("{:.3}",target as f32));
    assert_eq!(f,flags);


}






#[test]
fn test_op() {
    let pn = "project";
    let pp = "D:\\labs\\project\\";

    check_ch(pp, pn, "0", 3.0, 1.0, 2.0, "00000000");
    check_ch(pp, pn, "0", 7.323, 7.8323, 7.323-7.8323, "00000000");
    check_ch(pp, pn, "0", 3.23947234, -100.2934829034, 3.239472343+100.2934829034, "00000000");
    check_ch(pp, pn, "0", 3.0*2.0_f64.powi(30), -100.0, 3.0* 2.0_f64.powi(30)+100.0 , "00000000");
}