
use std::fs::File;
use std::io::prelude::*;

pub fn read_file(path: &String) -> String {
    let mut file = File::open(path).unwrap();
    let mut contents = String::new();
    file.read_to_string(&mut contents).unwrap();

    contents
}

pub fn write_file(path: &String, contents: &String) {
    let mut file = File::create(path).unwrap();
    file.write_all(contents.as_bytes()).unwrap();
}