

use std::fmt;

use crate::transport_task::data::Data;



impl fmt::Display for Data {
    
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        
        write!(f, "{}\n{}\n{}\n{}\n{}\n{}\n{}\n{}", 
            {
                let mut s = String::new();
                for item in self.needs.iter() {
                    s = format!("{}{:^5}", s, item)
                }
                s
            },
            {
                format!("{:-<25}", "")
            },
            {
                let mut s = String::new();
                for (i, vec) in self.costs.iter().enumerate() {
                    for item in vec {
                        s = format!("{}{:^5}", s, item);
                    }
                    
                    s = s + "|";
                    s = format!("{}{:^5}", s, self.reserves[i]);
                    s = s + "\n"
                }
                s
            },
            {
                format!("{:+<25}", "")
            },
            {
                let mut s = String::new();
                for item in self.needs.iter() {
                    s = format!("{}{:^5}", s, item)
                }
                s
            },
            {
                format!("{:-<25}", "")
            },
            {
                let mut s = String::new();
                for (i, vec) in self.routes.iter().enumerate() {
                    for item in vec {
                        s = format!("{}{:^5}", s, item);
                    }
                    
                    s = s + "|";
                    s = format!("{}{:^5}", s, self.reserves[i]);
                    s = s + "\n"
                }
                s
            },
            {
                format!("{:=<25}", "")
            }
        )
    }
}