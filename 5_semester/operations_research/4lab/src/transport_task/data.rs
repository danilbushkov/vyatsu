

#[derive(Debug, PartialEq)]
pub struct Data {
    pub costs: Vec<Vec<usize>>,
    pub reserves: Vec<usize>,
    pub needs: Vec<usize>,
    pub number_of_providers: usize,
    pub number_of_clients: usize,
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