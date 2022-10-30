

use crate::data::TBLData;


// GROUP CREATE
// INPUTS clk reset x;
// OUTPUTS y p PRS DEL result Z;
// UNIT ns;
// RADIX HEX;
// PATTERN
pub fn generate(data: &TBLData) -> String {
    let mut string = String::new();

    //GROUP CREATE
    for item in &data.groups {
        string = string + "GROUP CREATE " + item.0 + " = ";

        for i in (0..*item.1).rev() {
            string = string + item.0 +"[" + &i.to_string() + "] ";
        }

        string = string + ";\n";
    }

    // INPUTS clk reset x;
    string += "INPUTS ";
    for item in &data.inputs {
        string += item;
        string += " ";
    }
    string += ";\n";

    // OUTPUTS y p PRS DEL result Z;
    string += "OUTPUTS ";
    for item in &data.outputs {
        string += item;
        string += " ";
    }
    string += ";\n";

    // UNIT ns;
    string = string + "UNIT " + &data.unit + ";\n";

    // RADIX HEX;
    string = string + "RADIX " + &data.radix + ";\n";


    string += "PATTERN\n";

    for _ in 0..9 {

        string += "0.0";
        string += "> ";

        for item in &data.inputs {
            if let Some(v) = data.groups.get(item) {
                let m = if v % 4 == 0 {0} else {1};
                for _ in 0..(v / 4 + m) {
                    string += "0";
                } 
            } else {
                string += "0";
            }
            string += " ";
        }

        string += "= ";

        for item in &data.outputs {
            if let Some(v) = data.groups.get(item) {
                let m = if v % 4 == 0 {0} else {1};
                for _ in 0..(v / 4 + m) {
                    string += "0";
                } 
            } else {
                string += "0";
            }
            string += " ";
        }

        string += "\n";
    }
    string += ";";

    string
}   