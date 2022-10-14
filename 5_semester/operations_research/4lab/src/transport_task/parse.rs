


use crate::transport_task::data::Data;


pub fn parse(mut string: String) -> Data {
    
    let mut costs: Vec<Vec<isize>> = vec![];
    let mut reserves: Vec<isize> = vec![];
    let mut needs: Vec<isize> = vec![];
    let mut number_of_providers: usize = 0;
    let mut number_of_clients: usize = 0;
    let mut routes: Vec<Vec<isize>> = vec![];
    let mut involved_routes: Vec<(usize, usize)> = vec![];


    string.retain(|c| 
        (c >= '0' && c <= '9') ||
        c == ';' ||
        c == ','
    );

    let parts: Vec<&str> = string.split(';').collect();
    
    reserves = parts[0].split(',').collect::<Vec<&str>>().iter()
                .map(|item| item.parse::<isize>().unwrap()).collect();
    needs = parts[1].split(',').collect::<Vec<&str>>().iter()
                .map(|item| item.parse::<isize>().unwrap()).collect();

    number_of_providers = reserves.len();
    number_of_clients = needs.len();

    

    let right: Vec<isize> = parts[2].split(',').collect::<Vec<&str>>().iter()
                .map(|item| item.parse::<isize>().unwrap()).collect();
    
    let mut right: &[isize] = &right;
    let mut left: &[isize] = &[];
    for _ in 0..(right.len()/number_of_clients) {
        (left, right) = right.split_at(number_of_clients);
        costs.push(Vec::from(left));
        routes.push(vec![0; number_of_clients]);
    }

    
    Data {
        costs,
        reserves,
        needs,
        number_of_providers,
        number_of_clients,
        routes,
        involved_routes,
    }
}



#[test]
fn test_parse_0() {
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
        routes: vec![vec![0, 0, 0], 
                    vec![0, 0, 0], 
                    vec![0, 0, 0]],
        involved_routes: vec![],
                    
    };

    assert_eq!(data, parse(string));
}

#[test]
fn test_parse_1() {
    let string = "
        Reserves: 1, 2, 3, 5 ;
        Needs: 10, 4, 1 ;
        Costs(a/b):
        1, 2, 3,
        5, 6, 7,
        8, 9, 10,
        1, 1, 1
    
        end
    ".to_string();
    
    let data = Data {
        costs: vec![vec![1, 2, 3], 
                    vec![5, 6, 7], 
                    vec![8, 9, 10],
                    vec![1, 1, 1]],
        reserves: vec![1, 2, 3, 5],
        needs: vec![10, 4, 1],
        number_of_providers: 4,
        number_of_clients: 3,
        routes: vec![vec![0, 0, 0], 
                    vec![0, 0, 0], 
                    vec![0, 0, 0],
                    vec![0, 0, 0]],
        involved_routes: vec![],
    };

    assert_eq!(data, parse(string));
}

#[test]
fn test_parse_2() {
    let string = "
        Reserves: 1, 2, 3, 5 ;
        Needs: 10, 4, 1, 4, 4 ;
        Costs(a/b):
        1, 2, 3, 5, 1,
        5, 6, 7, 10, 2,
        8, 9, 10, 7, 5,
        1, 1, 1, 0, 3
    
        end
    ".to_string();
    
    let data = Data {
        costs: vec![vec![1, 2, 3, 5, 1], 
                    vec![5, 6, 7, 10, 2], 
                    vec![8, 9, 10, 7, 5],
                    vec![1, 1, 1, 0, 3]],
        reserves: vec![1, 2, 3, 5],
        needs: vec![10, 4, 1, 4, 4],
        number_of_providers: 4,
        number_of_clients: 5,
        routes: vec![vec![0, 0, 0, 0, 0], 
                    vec![0, 0, 0, 0, 0], 
                    vec![0, 0, 0, 0, 0],
                    vec![0, 0, 0, 0, 0]],
        involved_routes: vec![],
    };

    assert_eq!(data, parse(string));
}