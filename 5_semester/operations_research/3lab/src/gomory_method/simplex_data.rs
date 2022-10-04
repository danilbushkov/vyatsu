use crate::simplex::simplex_data::SimplexData;


impl SimplexData {
    pub fn add_constraint(&mut self, mut left: Vec<f64>, condition: String, right: f64) {
        left.push(right);
        self.constraints_coefficients.push(left);
        self.num_of_constraints += 1;
        self.basis.push(None);
        self.conditions.push(condition);
    }
}
