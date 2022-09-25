use std::io;


fn main() {
    let mut input = input();

    

    


}

struct SimplexData {
    num_of_var: usize,
    num_of_constraint: usize,
    direction: usize,
    coeff: Vec<f64>,
    constraints_coefficients: Vec<Vec<f64>>,
    conditions: Vec<String>,
}


fn parse(s: String) -> SimplexData {
    let mut s = s;

    s.retain(|c| 
        (c >= '0' && c<= '9') ||
        c == ';' || 
        c == '.' ||
        c == ' ' ||
        c == '=' ||
        c == '>' ||
        c == '<' 
    );
    SimplexData {}
}


fn input() -> String {
    let mut s = String::new();
    let mut input = String::new();
    while s != "end" {
        s = String::new();
        if let Err(e) = io::stdin().read_line(&mut s) {
            panic!("{:?}", e);
        }
        s = s.trim().to_string();
        input += &s;
    }
    
    input
}