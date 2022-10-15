use std::fmt;
use std::collections::HashSet;



pub const M: f64 = 10000.0;

pub struct SimplexData {
    pub num_of_vars_in_f: usize,
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
        
        for i in 0..(self.deltas.len()-1) {
            if self.direction == 0 {
                if self.deltas[i] > 0.0 {
                    return false;
                }
            }else {
                if self.deltas[i] < 0.0 {
                    return false;
                }
            }
        }
        true
    }

    fn get_resolving_column_index(&mut self) -> usize {
        let mut column_index = 0;
        for i in 1..self.num_of_vars {
            if self.direction == 0 {
                if self.deltas[i] > self.deltas[column_index] {
                    column_index = i;
                }
            } else {
                if self.deltas[i] < self.deltas[column_index] {
                    column_index = i;
                }
            }
        }

        column_index
    }

    pub fn move_to_optimal_solution(&mut self) -> bool {
        let mut Q: Vec<(usize, f64)> = Vec::new();
        let column_index = self.get_resolving_column_index();
        for i in 0..self.num_of_constraints {
            let a = self.constraints_coefficients[i][column_index];
            let b = self.constraints_coefficients[i][self.num_of_vars];
            if a > 0.0 {
                Q.push((i, b/a));
            } 
        }


        if Q.is_empty() {
            return false;
        }

        let mut index: usize = Q[Q.len()-1].0;
        let mut min: f64 = Q[Q.len()-1].1;


        if index > 0 {
            for i in (0..(Q.len()-1)).rev() {
                if Q[i].1 <= min {
                    min = Q[i].1;
                    index = Q[i].0;
                }
            }
        }
        

        self.basis[index] = Some(column_index);
        let value = self.constraints_coefficients[index][column_index];
        for item in self.constraints_coefficients[index].iter_mut() {
            *item = *item / value;
        }

        for i in 0..self.num_of_constraints {
            

            if i != index {
                let c = self.constraints_coefficients[i][column_index];
                for j in 0..=self.num_of_vars {
                    let v = self.constraints_coefficients[index][j];
                    let item = &mut self.constraints_coefficients[i][j];
                    
                    *item = *item - v*c;
                }
            }
        }


        true
    }
   
    pub fn check_artificial_variables_in_basis(&mut self) -> bool {
        for (i, item) in self.basis.iter().enumerate() {
            match item {
                Some(v) => {
                    if self.artificial_variables.contains(&v) 
                        && self.constraints_coefficients[i][self.num_of_vars] != 0.0 {
                        return true;
                    }
                },
                None => return true,
            }
        }


        false
    }

    pub fn print_result(&mut self) {
        let mut result: Vec<f64> = vec![0.0; self.num_of_vars_in_f];
        println!("Result: ");
        for (i, item) in self.basis.iter().enumerate() {
            if let Some(v) = item {
                if *v < self.num_of_vars_in_f {
                    result[*v] = self.constraints_coefficients[i][self.num_of_vars];
                }
            }
        }
        let mut s = String::new();
        for (_, item) in result.iter().enumerate() {
            s = format!("{} {:8.5}", s, item);
        }
        println!("{}", s);

        println!("F = {:8.5}", self.deltas[self.num_of_vars]);

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

    pub fn check_many_solutions(&self) -> bool {
        let mut c = 0;
        for i in 0..self.num_of_vars {
            if self.deltas[i] == 0.0 {
                c += 1;
            }
        }
        if c > self.num_of_constraints {
            return true;
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
                    s = format!("{}{:^8.4}", s, i);
                    
                }
                s = s + "\n";
                for _ in 0..self.num_of_vars {
                    s = format!("{}{:->8.4}", s, '-');
                    
                }
                s
            },
            { 
                let mut s = String::new();
                for item in self.coefficients.iter() {
                    s = format!("{}{:^8.4}", s, item);
                    
                }
                s
            },
            { 
                let mut s = String::new();
                for vec in self.constraints_coefficients.iter() {
                    for item in vec {
                        
                        s = format!("{}{:^8.4}", s, item);
                    }
                    s = s + "\n";
                }
                s
            },
            {

                let mut s = String::from("Basis: ");
                for item in &self.basis {
                    match item {
                        Some(v) => s = format!("{}{:<5.4}", s, v),
                        None => s = format!("{}{:>5}", s, 'n')
                    }
                }
                
                s
            },
            {
                let mut s = String::from("Artificial variables: ");
                for item in &self.artificial_variables {
                    s = format!("{}{:<8.4}", s, item);
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
                    
                    s = format!("{}{:^8.4}", s, item);
                }
                s
            }
            
        )
    }



}