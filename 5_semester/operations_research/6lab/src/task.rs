

use crate::data::Data;
use crate::parse::parse;
use std::collections::LinkedList;

pub fn task(data: Data) -> (LinkedList<(usize, isize)>, isize) {
    let mut list: LinkedList<(usize, isize)> = LinkedList::new();
    let mut result = 0;


    let mut profit = data.profits[0].clone();
    let mut profits: Vec<(Vec<isize>, Vec<(usize, usize)>)> = vec![];
    for i in 1..data.profits.len() {
        
        let tmp = get_best_profit(&profit, &data.profits[i]);
        profit = tmp.0.clone();
        profits.push(tmp);
    }

    
    let mut index: usize = match profits.last() {
        Some((p, v)) => {
            let mut index = 0;
            let mut max = 0;
            for (i, item) in p.iter().enumerate() {
                if *item > max {
                    max = *item;
                    index = i;
                }
            } 
            result = max;
            list.push_back((profits.len(), data.attachments[v[index].1]));
            v[index].0
            
        },
        None => {
            0
        }
    };

    for i in (0..profits.len()-1).rev() {
        list.push_front((i+1, data.attachments[profits[i].1[index].1]));
        index = profits[i].1[index].0;
    }

    list.push_front((0, data.attachments[index]));
    


    (list, result)
}



fn get_best_profit(profit1: &Vec<isize>, profit2: &Vec<isize>) -> (Vec<isize>, Vec<(usize, usize)>) {
    let mut best_profit: Vec<isize> = vec![];
    let mut companies: Vec<(usize, usize)> = vec![];
    let mut profits: Vec<Vec<isize>> = vec![];

    for _ in 0..profit1.len() {
        profits.push(vec![0; profit1.len()]);
    }

    for i in 0..profit1.len() {
        for j in 0..profit1.len()-i {
            profits[i][j] = profit1[i] + profit2[j];
        } 
    }
    println!("{}", get_table(&profits));
    
    for k in 0..profit1.len() {
        let mut i = k as isize;
        let mut j = 0;
        let mut max = 0;
        let mut index1 = 0;
        let mut index2 = 0;
        while i >= 0 as isize {
            
            if profits[i as usize][j] > max {
                max = profits[i as usize][j];
                index1 = i; 
                index2 = j;
            }



            i -= 1;
            j += 1;
            
        }
        best_profit.push(max);
        companies.push((index1 as usize, index2));        
    }

    println!("{}", get_best((&best_profit, &companies)));
    (best_profit, companies)
}  

fn get_table(table: &Vec<Vec<isize>>) -> String {
    let mut s = "".to_string();
    for vec in table {
        for item in vec {
            s = format!("{}{:^5}", s, item);
        }
        s = s + "\n"
    }
    s
}

fn get_best(best: (&Vec<isize>, &Vec<(usize, usize)>)) -> String {
    let mut s = "".to_string();
    for i in 0..best.0.len() {
        
        s = format!("{}{:>5}:[{}, {}]", s, best.0[i], best.1[i].0, best.1[i].1);
        
        s = s + "\n"
    }
    s
}



#[test]
fn test_task_0() {
    let string = "
        x: 1, 3, 6 ;
        f: 1, 5, 4 ;
        f: 2, 3, 1 ;
        f: 7, 1, 4 

        end
    ".to_string();
    
    
    let mut list: LinkedList<(usize, isize)> = LinkedList::from([
        (0, 3),(1, 0),(2, 1)
    ]);
    

    assert_eq!(task(parse(string.clone())), (list , 12));
}

#[test]
fn test_task_1() {
    let string = "
        x: 2, 6, 7, 8, 10, 16, 18 ;
        f: 3, 3, 1, 2, 8, 6, 3;
        f: 3, 2, 6, 4, 4, 3, 5;
        f: 9, 8, 1, 6, 5, 4, 8;
        f: 3, 2, 4, 5, 1, 1, 9

        end
    ".to_string();
    
    
    let mut list: LinkedList<(usize, isize)> = LinkedList::from([
        (0, 2),(1, 7),(2, 2),(3, 2)
    ]);
    

    assert_eq!(task(parse(string.clone())), (list , 21));
}


#[test]
fn test_task_2() {
    let string = "
        x: 2, 4, 7, 10 ;
        f: 3, 4, 3, 8 ;
        f: 2, 5, 7, 2 ;
        f: 3, 1, 5, 3 

        end
    ".to_string();
    
    
    let mut list: LinkedList<(usize, isize)> = LinkedList::from([
        (0, 2),(1, 4),(2, 2)
    ]);
    

    assert_eq!(task(parse(string.clone())), (list , 11));
}



