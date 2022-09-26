use std::io;


pub fn input() -> String {
    let mut s = String::new();
    let mut input = String::new();
    while s != "end" {
        s = String::new();
        if let Err(e) = io::stdin().read_line(&mut s) {
            panic!("{:?}", e);
        }
        s = s.trim().to_string();
        input += &s;
    }
    
    input
}