
use std::io;

pub fn input() -> String {
    let mut string = String::new();

    let mut buffer = "".to_string();
    let stdin = io::stdin();
    while buffer != "end" {
        buffer = "".to_string();
        if let Err(e) = stdin.read_line(&mut buffer) {
            panic!("{:?}", e);
        }
        buffer = buffer.trim().to_string();
        string += &buffer;
    }

    string 
}