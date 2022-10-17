
use crate::data::Data;


pub fn parse(mut string: String) -> Data {
    let mut attachments: Vec<isize> = vec![];
    let mut profits: Vec<Vec<isize>> = vec![];

    string.retain(|c| 
        (c >= '0' && c <= '9') ||
        c == ';' ||
        c == ',' 
        
    );

    let parts: Vec<&str> = string.split(';').collect();
    
    let mut vec: Vec<Vec<isize>> = vec![];
    for item in parts {
        vec.push(item.split(',').map(|a| a.parse::<isize>().unwrap()).collect());
    }
    if !vec.is_empty() {
        attachments = vec[0].clone();
    }
    
    for i in 1..vec.len() {
        profits.push(vec[i].clone());
    }
    
    Data {
        attachments,
        profits,
    }
}


#[test] 
fn test_parse() {
    let string = "
        x: 1, 3, 6 ;
        f: 1, 5, 4 ;
        f: 2, 3, 1 ;
        f: 4, 1, 4 

        end
    ".to_string();
    
    let attachments: Vec<isize> = vec![1, 3, 6];

    let profits: Vec<Vec<isize>> = vec![
        vec![1, 5, 4],
        vec![2, 3, 1],
        vec![4, 1, 4],
    ];  

    assert_eq!(parse(string.clone()).attachments, attachments);
    assert_eq!(parse(string.clone()).profits, profits);
}