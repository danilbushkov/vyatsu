

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


fn exponent_order(binary_number: u32) -> i32 {
    let bitmask: u32 = 1 << 31;
    let exponent = (binary_number & !bitmask) >> 23;

    if exponent >= 128 {
        return -1 * ((exponent as i32)-128)  
    } else {
        return exponent as i32
    }

    //(exponent as i32) - 128
}


pub fn order_b32_to_f64(binary_number: u32) -> f64 {
    let sign = sign(binary_number);
    let exponent = exponent_order(binary_number);
    let fraction = fraction(binary_number);

    sign * fraction * 2.0_f64.powi(exponent)
}


pub fn order_f64_to_b32(number: f64) -> u32 {
    let sign = number.signum();
    let mut number = number.abs();

    let mut exponent: i32 = 0;

    if number >= 1.0 {
        while number >= 1.0 {
            number /= 2.0;
            exponent +=1;
        }
    } else if number < 0.5 {
        exponent = exponent + 128;
        while number < 0.5 {
            number *= 2.0;
            exponent +=1;
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



#[test]
fn test_order() {
    let number = order_f64_to_b32(-5.0);
    assert_eq!(number, 0b1_00000011_10100000000000000000000);
    let number = order_f64_to_b32(8.0);
    assert_eq!(number, 0b0_00000100_10000000000000000000000);
    let number = order_f64_to_b32(0.03125);
    assert_eq!(number, 0b0_10000100_10000000000000000000000);

    let number = order_b32_to_f64(0b1_00000011_10100000000000000000000);
    assert_eq!(number, -5.0);
    let number = order_b32_to_f64(0b0_00000100_10000000000000000000000);
    assert_eq!(number, 8.0);
    let number = order_b32_to_f64(0b0_10000100_10000000000000000000000);
    assert_eq!(number, 0.03125);

}
