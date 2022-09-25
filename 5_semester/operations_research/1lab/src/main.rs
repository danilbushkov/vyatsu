use std::io;
use std::fmt;


fn main() {
    let mut input = input();
    let data = parse(input);
    

    println!("{}", data);


}


struct SimplexData {
    num_of_var: usize,
    num_of_constraint: usize,
    direction: usize,
    coefficients: Vec<f64>,
    constraints_coefficients: Vec<Vec<f64>>,
    conditions: Vec<String>,
}

impl fmt::Display for SimplexData {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}\n{}\n{}\n{}\n{}\n{}\n", 
            self.num_of_var,
            self.num_of_constraint,
            self.direction,
            { 
                let mut s = String::new();
                for item in self.coefficients.iter() {
                    s = s + &item.to_string() + " ";
                }
                s
            },
            { 
                let mut s = String::new();
                for vec in self.constraints_coefficients.iter() {
                    for item in vec {
                        s = s + &item.to_string() + " " ;
                    }
                    s = s + "\n";
                }
                s
            },
            { 
                let mut s = String::new();
                for item in self.conditions.iter() {
                    s = s + &item + " ";
                }
                s
            }
        )
    }
}



fn parse(s: String) -> SimplexData {
    let mut s = s;

    let mut data = SimplexData {
        num_of_var: 0,
        num_of_constraint: 0,
        direction: 0,
        coefficients: vec![],
        constraints_coefficients: vec![],
        conditions: vec![],
    };

    s.retain(|c| 
        (c >= '0' && c<= '9') ||
        c == ';' || 
        c == '.' ||
        c == ' ' ||
        c == '=' ||
        c == '>' ||
        c == '<' 
    );

    let mut lines: Vec<&str> = s.split(';').collect();
    for line in &mut lines {
        *line = line.trim();
    }
    data.num_of_var = lines[0].parse::<usize>().unwrap();
    data.num_of_constraint = lines[1].parse::<usize>().unwrap();
    data.direction = lines[2].parse::<usize>().unwrap();
    data.coefficients = 
        lines[3].split_whitespace().map(|item| item.parse::<f64>().unwrap()).collect();

    for i in 4..(4+data.num_of_constraint) {
        let mut iter = lines[i].split_whitespace();
        let mut vec: Vec<f64> = vec![];
        for _ in 0..data.num_of_var {
            vec.push(iter.next().unwrap().parse::<f64>().unwrap()); 
        }

        data.conditions.push(iter.next().unwrap().to_string());
        vec.push(iter.next().unwrap().parse::<f64>().unwrap());

        data.constraints_coefficients.push(vec);
    }

    data
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