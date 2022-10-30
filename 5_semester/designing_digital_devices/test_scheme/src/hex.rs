


pub fn hex_to_bin(number: &String) -> String {
    let mut string = String::new();

    for digit in number.chars().map(|c| c.to_string()) {
        string = string + &hex_digit_to_bin(digit.as_str());
    }
    string
}

pub fn bin_to_hex(number: &String) -> String {
    let mut string = String::new();

    for i in 0..number.len()/4 {
        string = string + &bin_to_hex_digit(&number[i*4..(i*4)+4]);
    }

    string
}


fn hex_digit_to_bin(digit: &str) -> String {
    match digit {
        "0" => "0000".to_string(),
        "1" => "0001".to_string(),
        "2" => "0010".to_string(),
        "3" => "0011".to_string(),
        "4" => "0100".to_string(),
        "5" => "0101".to_string(),
        "6" => "0110".to_string(),
        "7" => "0111".to_string(),
        "8" => "1000".to_string(),
        "9" => "1001".to_string(),
        "A" => "1010".to_string(),
        "B" => "1011".to_string(),
        "C" => "1100".to_string(),
        "D" => "1101".to_string(),
        "E" => "1110".to_string(),
        "F" => "1111".to_string(),
        _ => "".to_string(),
    } 
}

fn bin_to_hex_digit(digit: &str) -> String {
    match digit {
        "0000" => "0".to_string(),
        "0001" => "1".to_string(),
        "0010" => "2".to_string(),
        "0011" => "3".to_string(),
        "0100" => "4".to_string(),
        "0101" => "5".to_string(),
        "0110" => "6".to_string(),
        "0111" => "7".to_string(),
        "1000" => "8".to_string(),
        "1001" => "9".to_string(),
        "1010" => "A".to_string(),
        "1011" => "B".to_string(),
        "1100" => "C".to_string(),
        "1101" => "D".to_string(),
        "1110" => "E".to_string(),
        "1111" => "F".to_string(),
        _ => "".to_string(),
    } 
}



