use std::fmt;



pub const M: f64 = 10000.0;

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

        

        self.conditions.iter_mut().enumerate().for_each(|(i, condition)| {
            if condition == "<=" || condition == ">=" {
                self.coefficients.push(0.0);
            
                self.constraints_coefficients.iter_mut().enumerate().for_each(|(j, item)| {
                    if i == j {
                        if condition == ">=" {
                            item.insert(self.num_of_var, -1.0);
                            *condition = "=".to_string();
                        } else if condition == "<=" {
                            item.insert(self.num_of_var, 1.0);
                            self.basis[i] = Some(self.num_of_var);
                            *condition = "=".to_string();
                        }
                    } else {
                        item.insert(self.num_of_var, 0.0);
                    }
                });

                self.num_of_var += 1;
            }
        });
            
        
    }


    pub fn form_basis(&mut self) {
        for i in 0..self.num_of_var {
            let mut index = 0;
            let mut number_of_non_zeros = 0;
            for j in 0..self.num_of_constraint {
                if self.constraints_coefficients[j][i] != 0.0 {
                    number_of_non_zeros += 1;
                    index = j;
                } 
            }
            if number_of_non_zeros == 1 && 
               self.constraints_coefficients[index][i] == 1.0 {
                
                if let None = self.basis[index] {
                    self.basis[index]= Some(i);
                }
            }
        }


        self.basis.iter_mut().enumerate().for_each(|(i, item)| {
            if let None = item {
                *item = Some(self.num_of_var);
                for j in 0..self.num_of_constraint {
                    if i == j {
                        self.constraints_coefficients[j].insert(self.num_of_var, 1.0);
                    } else {
                        self.constraints_coefficients[j].insert(self.num_of_var, 0.0);
                    }
                }
                if self.direction == 0 {
                    self.coefficients.insert(self.num_of_var, M);
                } else {
                    self.coefficients.insert(self.num_of_var, -M);
                }
                
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
        write!(f, "{}\n{}\n{}\n{}\n{}\n\n{}\n{}\n{}\n", 
            self.num_of_var,
            self.num_of_constraint,
            self.direction,
            {
                let mut s = String::new();
                for i in 0..self.num_of_var {
                    s = format!("{}{:8}", s, i);
                    
                }
                s = s + "\n";
                for i in 0..self.num_of_var {
                    s = format!("{}{:->8}", s, '-');
                    
                }
                s
            },
            { 
                let mut s = String::new();
                for item in self.coefficients.iter() {
                    s = format!("{}{:8}", s, item);
                    
                }
                s
            },
            { 
                let mut s = String::new();
                for vec in self.constraints_coefficients.iter() {
                    for item in vec {
                        
                        s = format!("{}{:8}", s, item);
                    }
                    s = s + "\n";
                }
                s
            },
            {
                let mut s = String::new();
                for item in &self.basis {
                    match item {
                        Some(v) => s = format!("{}{:8}", s, v),
                        None => s = format!("{}{:>8}", s, 'n')
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