mod app;
mod gost;
mod polybius_square;
mod rsa;
mod tasks;
mod tiger;

use gtk::prelude::*;
use gtk::{glib, Application};

const APP_ID: &str = "org.gtk_rs.data_protection.lab3";

fn main() -> glib::ExitCode {
    let app = Application::builder().application_id(APP_ID).build();
    app.connect_activate(app::build_ui);
    app.run()

    //   let (x, _, _) = rsa::gcd(BigInt::from(23), BigInt::from(2341));
    //   println!("{}", x);
    //   let v = rsa::sieve_of_eratosthenes(300);
    //   println!("{:?}", v);
    //   let keys = rsa::new_keys(BigUint::from(659 as u32), BigUint::from(599 as u32));
    //   println!("{:?}", keys);

    //   let m = "Привет!".as_bytes();
    //   let c = rsa::encrypt(m, &keys.0);
    //   println!("{:?} -> {:?}", m, c);
    //   println!();
    //   let s: String = c
    //       .iter()
    //       .map(|v| v.to_str_radix(16))
    //       .collect::<Vec<_>>()
    //       .join(".");
    //   println!("{}", s);
    //   let c = s
    //       .split('.')
    //       .map(|s| BigUint::from_str_radix(s, 16).unwrap_or(BigUint::from(0 as u32)))
    //       .collect::<Vec<_>>();
    //   let m = rsa::decrypt(&c, &keys.1);
    //   println!("{:?}", m);
}
