

pub fn f64_to_b32(number: f64) -> u32 {
    let sign = number.signum();
    let mut number = number.abs();

    let mut exponent: i32 = 128;

    if number >= 1.0 {
        while number >= 1.0 {
            number /= 2.0;
            exponent +=1;
        }
    } else if number < 0.5 {
        while number < 0.5 {
            number *= 2.0;
            exponent -=1;
        }
    }

    let mut fraction: u32 = 0;
    for _ in 0..22 {
        number *= 2.0;
        if number >= 1.0 {
            number -= 1.0;
            fraction = fraction + 1;
        } 
        fraction = fraction << 1;
    } 
    number *= 2.0;
    if number >= 1.0 {
        fraction = fraction + 1;
    } 

    let sign: u32 = if sign > 0.0 {
        0
    } else {
        1 << 31
    };
    

    let exponent = (exponent as u32) << 23;
    

    sign | exponent | fraction
}




pub fn b32_to_f64(binary_number: u32) -> f64 {
    let sign = sign(binary_number);
    let exponent = exponent(binary_number);
    let fraction = fraction(binary_number);

    sign * fraction * 2.0_f64.powi(exponent)
}



fn sign(binary_number: u32) -> f64 {
    let bitmask: u32 = 1 << 31;
    match binary_number & bitmask {
        0 => 1.0,
        _ => -1.0,
    }
}

fn exponent(binary_number: u32) -> i32 {
    let bitmask: u32 = 1 << 31;
    let exponent = (binary_number & !bitmask) >> 23;

    (exponent as i32) - 128
}

fn fraction(binary_number: u32) -> f64 {
    let bitmask: u32 = 0b1_11111111 << 23;
    let number = (binary_number & !bitmask) as f64;
    let fraction: f64 = number / 2.0_f64.powi(23);

    fraction
}


