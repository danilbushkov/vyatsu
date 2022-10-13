
use crate::transport_task::data::Data;


pub fn parse(mut string: String) -> Data {
    
    let mut costs: Vec<Vec<usize>> = vec![];
    let mut reserves: Vec<usize> = vec![];
    let mut needs: Vec<usize> = vec![];
    let mut number_of_providers: usize = 0;
    let mut number_of_clients: usize = 0;


    string.retain(|c| 
        (c >= '0' && c <= '9') ||
        c == ';' ||
        c == ','
    );

    let parts: Vec<&str> = string.split(';').collect();
    




    Data {
        costs,
        reserves,
        needs,
        number_of_providers,
        number_of_clients,
    }
}



#[test]
fn test_parse() {
    let string = "
        Reserves: 1, 2, 3 ;
        Needs: 10, 4, 1 ;
        Costs(a/b):
        1, 2, 3,
        5, 6, 7,
        8, 9, 10 
    
        end
    ".to_string();




    let data = Data {
        costs: vec![vec![1, 2, 3], 
                    vec![5, 6, 7], 
                    vec![8, 9, 10]],
        reserves: vec![1, 2, 3],
        needs: vec![10, 4, 1],
        number_of_providers: 3,
        number_of_clients: 3,
    };

    assert_eq!(data, parse(string));
}