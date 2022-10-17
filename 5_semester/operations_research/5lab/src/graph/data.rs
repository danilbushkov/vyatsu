
use std::collections::HashMap;
use std::fmt;


pub type Edges = HashMap<usize, HashMap<usize, isize>>;


pub struct Graph {
    pub edges: Edges,
    pub number_of_vertices: usize,
}







