use std::fmt;

pub struct SimplexData {
    pub num_of_var: usize,
    pub num_of_constraint: usize,
    pub direction: usize,
    pub coefficients: Vec<f64>,
    pub constraints_coefficients: Vec<Vec<f64>>,
    pub conditions: Vec<String>,
}

impl SimplexData {
    pub fn canonical_view(&mut self) {
        for i in 0..self.num_of_constraint {
            if self.conditions[i] == ">=" {
                self.conditions[i] = "<=".to_string();

                self.constraints_coefficients[i].iter_mut().for_each(|item| {
                    *item = -(*item);
                });
            }
        }


        for i in 0..self.num_of_constraint {
            if self.conditions[i] == "<=" {
                self.conditions[i] = "=".to_string();

                
                self.coefficients.push(0.0);
            


                self.constraints_coefficients.iter_mut().enumerate().for_each(|(j, item)| {
                    if i == j {
                        item.insert(self.num_of_var, 1.0);
                    } else {
                        item.insert(self.num_of_var, 0.0);
                    }
                });

                self.num_of_var += 1;
            }
        }
    }
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
                    s = format!("{}{:5}", s, item);
                    
                }
                s
            },
            { 
                let mut s = String::new();
                for vec in self.constraints_coefficients.iter() {
                    for item in vec {
                        
                        s = format!("{}{:5}", s, item);
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