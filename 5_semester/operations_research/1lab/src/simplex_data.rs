use std::fmt;
use std::collections::HashSet;



pub const M: f64 = 10000.0;

pub struct SimplexData {
    pub num_of_vars: usize,
    pub num_of_constraints: usize,
    pub direction: usize,
    pub coefficients: Vec<f64>,
    pub constraints_coefficients: Vec<Vec<f64>>,
    pub conditions: Vec<String>,
    pub basis: Vec<Option<usize>>,
    pub artificial_variables: HashSet<usize>,
    pub deltas: Vec<f64>,
}

impl SimplexData {


    pub fn preparatory_stage(&mut self) {

        self.constraints_coefficients.iter_mut().enumerate().for_each(|(i ,item)| {
            if 0.0 > item[self.num_of_vars] {
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
                            item.insert(self.num_of_vars, -1.0);
                            *condition = "=".to_string();
                        } else if condition == "<=" {
                            item.insert(self.num_of_vars, 1.0);
                            self.basis[i] = Some(self.num_of_vars);
                            *condition = "=".to_string();
                        }
                    } else {
                        item.insert(self.num_of_vars, 0.0);
                    }
                });

                self.num_of_vars += 1;
            }

        });
            
        
    }


    pub fn form_basis(&mut self) {
        for i in 0..self.num_of_vars {
            let mut index = 0;
            let mut number_of_non_zeros = 0;
            for j in 0..self.num_of_constraints {
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
                *item = Some(self.num_of_vars);
                for j in 0..self.num_of_constraints {
                    if i == j {
                        self.constraints_coefficients[j].insert(self.num_of_vars, 1.0);
                    } else {
                        self.constraints_coefficients[j].insert(self.num_of_vars, 0.0);
                    }
                }
                if self.direction == 0 {
                    self.coefficients.insert(self.num_of_vars, M);
                } else {
                    self.coefficients.insert(self.num_of_vars, -M);
                }
                self.artificial_variables.insert(self.num_of_vars);
                
                self.num_of_vars += 1;
            }
        });
        self.coefficients.push(0.0);
    }

    pub fn calculate_deltas(&mut self) {
        self.deltas = vec![0.0; self.num_of_vars+1];
        self.deltas.iter_mut().enumerate().for_each(|(i, item)| {
            for j in 0..self.num_of_constraints {
                match self.basis[j] {
                    Some(v) => {
                        *item += self.coefficients[v]*self.constraints_coefficients[j][i];
                    }
                    None => panic!("No value in basis!"),
                }
            }
            *item -= self.coefficients[i];
        });

    }

    pub fn check_optimality(&mut self) -> bool {
        for item in &self.deltas {
            if self.direction == 0 {
                if *item > 0.0 {
                    return false;
                }
            }else {
                if *item < 0.0 {
                    return false;
                }
            }
        }
        true
    }


   


    pub fn _canonical_view(&mut self) {
        for i in 0..self.num_of_constraints {
            if self.conditions[i] == ">=" {
                self.conditions[i] = "<=".to_string();

                self.constraints_coefficients[i].iter_mut().for_each(|item| {
                    *item = -(*item);
                });
            }
        }


        for i in 0..self.num_of_constraints {
            if self.conditions[i] == "<=" {
                self.conditions[i] = "=".to_string();

                
                self.coefficients.push(0.0);
            


                self.constraints_coefficients.iter_mut().enumerate().for_each(|(j, item)| {
                    if i == j {
                        item.insert(self.num_of_vars, 1.0);
                    } else {
                        item.insert(self.num_of_vars, 0.0);
                    }
                });

                self.num_of_vars += 1;
            }
        }
    }


    pub fn _check_basis(&self) -> bool {
        for item in &self.basis {
            if let None = item {
                return false;
            }
        }

        true
    }
}






impl fmt::Display for SimplexData {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}\n{}\n{}\n{}\n{}\n\n{}\n{}\n{}\n{}\n{}\n", 
            "number of variables: ".to_string() + &format!("{}", self.num_of_vars),
            "number of constraints: ".to_string() + &format!("{}",self.num_of_constraints),
            "min(0) or max(1): ".to_string() + &format!("{}", self.direction) + "\n",
            {
                let mut s = String::new();
                for i in 0..self.num_of_vars {
                    s = format!("{}{:^8}", s, i);
                    
                }
                s = s + "\n";
                for i in 0..self.num_of_vars {
                    s = format!("{}{:->8}", s, '-');
                    
                }
                s
            },
            { 
                let mut s = String::new();
                for item in self.coefficients.iter() {
                    s = format!("{}{:^8}", s, item);
                    
                }
                s
            },
            { 
                let mut s = String::new();
                for vec in self.constraints_coefficients.iter() {
                    for item in vec {
                        
                        s = format!("{}{:^8}", s, item);
                    }
                    s = s + "\n";
                }
                s
            },
            {

                let mut s = String::from("Basis: ");
                for item in &self.basis {
                    match item {
                        Some(v) => s = format!("{}{:<5}", s, v),
                        None => s = format!("{}{:>5}", s, 'n')
                    }
                }
                
                s
            },
            {
                let mut s = String::from("Artificial variables: ");
                for item in &self.artificial_variables {
                    s = format!("{}{:<8}", s, item);
                }

                s
            },
            { 
                let mut s = String::from("Conditions: ");
                for item in self.conditions.iter() {
                    
                    s = s + &item + " ";
                }
                s
            },
            {
                let mut s = String::from("Deltas: \n");
                for item in self.deltas.iter() {
                    
                    s = format!("{}{:^8}", s, item);
                }
                s
            }
            
        )
    }
}