use crate::simplex_data::SimplexData;


pub fn parse(s: String) -> SimplexData {
    let mut s = s;

    let mut data = SimplexData {
        num_of_var: 0,
        num_of_constraint: 0,
        direction: 0,
        coefficients: vec![],
        constraints_coefficients: vec![],
        conditions: vec![],
        basis: vec![],
    };

    s.retain(|c| 
        (c >= '0' && c<= '9') ||
        c == ';' || 
        c == '.' ||
        c == ' ' ||
        c == '=' ||
        c == '>' ||
        c == '<' ||
        c == '-' 
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
        data.basis.push(None);
    }

    data
}