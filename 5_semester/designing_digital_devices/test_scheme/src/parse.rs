
use std::collections::{LinkedList, HashMap};

use crate::data::TBLData;

pub fn parse(string: String) -> TBLData {
    let mut groups: HashMap<String, usize> = HashMap::new();
    let mut inputs: Vec<String> = vec![];
    let mut outputs: Vec<String> = vec![];
    let mut radix: String = String::new();
    let mut unit: String = String::new();


    let mut tmp: LinkedList<&str> = string.split(";").collect();
    tmp.pop_back();



    let mut patterns: Vec<String> = tmp.back().unwrap().split('\n').map(|s| s.to_string()).collect();
    tmp.pop_back();


    while !tmp.is_empty() {
        let mut st = tmp.pop_back().unwrap();
        st.trim();
        if st.contains("GROUP CREATE") {
            
            st = &st[st.find("GROUP CREATE").unwrap()+"GROUP CREATE".len()..];
            let mut t: Vec<&str> = st.split('=').collect();
            

            groups.insert(t[0].trim().to_string(), 
                t[1].split_whitespace().collect::<Vec<&str>>().len());
            


        } else if st.contains("INPUTS") {
            st = &st[st.find("INPUTS").unwrap()+"INPUTS".len()..];
            
            inputs = st.split_whitespace().map(|s| s.to_string()).collect();


        } else if st.contains("OUTPUTS") {
            st = &st[st.find("OUTPUTS").unwrap()+"OUTPUTS".len()..];
            outputs = st.split_whitespace().map(|s| s.to_string()).collect();

        } else if st.contains("UNIT") {
            st = &st[st.find("UNIT").unwrap()+"UNIT".len()..];
            unit = st.trim().to_string();

        } else if st.contains("RADIX") {
            st = &st[st.find("RADIX").unwrap()+"RADIX".len()..];
            radix = st.trim().to_string();
        }


    }


    TBLData {
        inputs,
        outputs,
        groups,
        patterns,
        radix,
        unit,
    }
}