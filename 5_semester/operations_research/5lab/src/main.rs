mod input;
mod graph;

use crate::graph::Graph;
use crate::graph::{find_shortcut, parse};

fn main() {
    let string = "
            a   b   c   d   e   f   g   h
        a   1,  5,  1,  0,  2,  0,  0,  0;
        b   0,  0,  0,  0, -1,  0,  0,  0;
        c   0,  0,  0,  2,  0,  4,  0,  2;
        d   2,  0,  0,  0,  0,  0,  1,  0;
        e   0,  0,  0,  0,  0,  0,  3,  0;
        f   0,  0,  0,  0,  0,  0,  1,  0;
        g   0,  0,  0,  0,  0,  0,  0,  0;
        h  -1,  0,  0,  0,  0,  0,  0,  0
    ".to_string();



    find_shortcut(&parse(string), 0, 6);
    println!("Hello, world!");
}
