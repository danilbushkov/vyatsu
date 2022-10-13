

#[derive(Debug, PartialEq)]
pub struct Data {
    pub costs: Vec<Vec<isize>>,
    pub reserves: Vec<isize>,
    pub needs: Vec<isize>,
    pub number_of_providers: usize,
    pub number_of_clients: usize,
    pub routes: Vec<Vec<isize>>,
}



impl Data {
    

    pub fn add_fictitious_reserve(&mut self, reserve: isize) {
        self.reserves.push(reserve);
        self.costs.push(vec![0; self.number_of_clients]);

    } 

    pub fn add_fictitious_need(&mut self, need: isize) {
        self.needs.push(need);
        for item in self.costs.iter_mut() {
            item.push(0);
        }
    } 

    pub fn get_amount_reserves(&self) -> isize {
        let mut amount = 0;
        for item in &self.reserves {
            amount += item;
        }

        amount
    }

    pub fn get_amount_needs(&self) -> isize {
        let mut amount = 0;
        for item in &self.needs {
            amount += item;
        }

        amount
    }
}


