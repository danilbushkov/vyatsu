




pub struct SimplexResult {
    pub vec: Vec<f64>,
    pub f: f64,
}



impl SimplexResult {
    pub fn print(&self) {
        let mut s = String::new();
        for (_, item) in self.vec.iter().enumerate() {
            s = format!("{} {:8.5}", s, item);
        }
        println!("{}", s);

        println!("F = {:8.5}", self.f);
    }
}