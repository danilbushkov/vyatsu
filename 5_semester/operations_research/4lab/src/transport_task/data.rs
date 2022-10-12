


pub struct Data {
    costs: Vec<Vec<usize>>,
    reserves: Vec<usize>,
    needs: Vec<usize>,
    number_of_providers: usize,
    number_of_clients: usize,
    
}



impl Data {
    pub fn getAmountReserves(&self) -> usize {
        let mut amount = 0;
        for item in &self.reserves {
            amount += item;
        }

        amount
    }

    pub fn getAmountNeeds(&self) -> usize {
        let mut amount = 0;
        for item in &self.needs {
            amount += item;
        }

        amount
    }
}