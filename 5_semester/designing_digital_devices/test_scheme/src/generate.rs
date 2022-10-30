

use crate::data::TBLData;


// GROUP CREATE
// INPUTS clk reset x;
// OUTPUTS y p PRS DEL result Z;
// UNIT ns;
// RADIX HEX;
// PATTERN
pub fn generate(data: &TBLData, clk_ns: f64, number1: &String, number2: &String) -> String {
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


    let mut ns = clk_ns;
    let mut clk = "0";
    let mut num_clk = 0;
    let mut num1 = 2;
    let mut num2 = 4;

    for _ in 0..9 {

        string += &ns.to_string();
        string += "> ";

        for item in &data.inputs {
            if let Some(v) = data.groups.get(item) {
                if num_clk == num1 {
                    string += number1;
                } else if num_clk == num2 {
                    string += number2;
                } else {
                    let m = if v % 4 == 0 {0} else {1};
                    for _ in 0..(v / 4 + m) {
                        string += "0";
                    }
                } 
            } else {
                if item == "clk" {
                    string += clk;
                } else {
                    string += "0";
                }
                
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


        if clk == "1" {
            clk = "0";
        } else {
            clk = "1";
            num_clk += 1;
        }
        ns += clk_ns;
    }
    string += ";";

    string
}   