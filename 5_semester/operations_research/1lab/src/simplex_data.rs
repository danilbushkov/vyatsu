use std::fmt;

pub struct SimplexData {
    pub num_of_var: usize,
    pub num_of_constraint: usize,
    pub direction: usize,
    pub coefficients: Vec<f64>,
    pub constraints_coefficients: Vec<Vec<f64>>,
    pub conditions: Vec<String>,
    pub basis: Vec<Option<usize>>,
}

impl SimplexData {


    pub fn preparatory_stage(&mut self) {

        self.constraints_coefficients.iter_mut().enumerate().for_each(|(i ,item)| {
            if 0.0 > item[self.num_of_var] {
                item.iter_mut().for_each(|item| {
                    *item = -(*item);
                });
                if self.conditions[i] == ">=" {
                    self.conditions[i] = "<=".to_string();
                } else if self.conditions[i] == "<=" {
                    self.conditions[i] = ">=".to_string();
                }
            } 
        });

        

        self.conditions.iter().enumerate().for_each(|(i, condition)| {
            if condition == "<=" || condition == ">=" {
                self.coefficients.push(0.0);
            
                self.constraints_coefficients.iter_mut().enumerate().for_each(|(j, item)| {
                    if i == j {
                        if condition == ">=" {
                            item.insert(self.num_of_var, -1.0);
                        } else if condition == "<=" {
                            item.insert(self.num_of_var, 1.0);
                        }
                    } else {
                        item.insert(self.num_of_var, 0.0);
                    }
                });

                self.num_of_var += 1;
            }
        });
            
        

        
    }

    pub fn check_basis(&self) -> bool {
        for item in &self.basis {
            if let None = item {
                return false;
            }
        }

        true
    }


    pub fn _canonical_view(&mut self) {
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
        write!(f, "{}\n{}\n{}\n{}\n{}\n{}\n{}\n", 
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
                for item in &self.basis {
                    match item {
                        Some(v) => s = format!("{}{:5}", s, v),
                        None => s = format!("{}{:5}", s, "n")
                    }
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