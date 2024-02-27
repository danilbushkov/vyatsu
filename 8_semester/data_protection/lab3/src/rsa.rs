use num_bigint::{BigInt, BigUint};
use rand::seq::SliceRandom;

pub fn new_keys(p: BigUint, q: BigUint) -> ((BigUint, BigUint), (BigUint, BigUint)) {
    let mut _e: BigUint = BigUint::from(0 as u32);
    let mut _d: BigUint = BigUint::from(0 as u32);
    let n = &p * &q;
    let f = (p - 1 as u32) * (q - 1 as u32);
    loop {
        _e = BigUint::from(
            *sieve_of_eratosthenes(*(&f - 1 as u32).to_u64_digits().first().unwrap_or(&2) as usize)
                .choose(&mut rand::thread_rng())
                .unwrap(),
        );
        let (x, _, g) = gcd(BigInt::from(_e.clone()), BigInt::from(f.clone()));
        if x <= BigInt::from(0) || x >= BigInt::from(n.clone()) || g != BigInt::from(1) {
            continue;
        }
        _d = x.to_biguint().unwrap();
        break;
    }

    ((_e, n.clone()), (_d, n))
}

pub fn gcd(a: BigInt, b: BigInt) -> (BigInt, BigInt, BigInt) {
    let zero: BigInt = BigInt::from(0);
    let mut x = zero.clone();
    let mut y = zero.clone() + 1;
    if a == zero.clone() {
        return (x, y, b);
    }
    let (d, x1, y1);
    (x1, y1, d) = gcd(b.clone() % &a, a.clone());
    y = x1.clone();
    x = y1 - (b / a) * x1;
    (x, y, d)
}

pub fn sieve_of_eratosthenes(n: usize) -> Vec<usize> {
    if n < 2 {
        return vec![];
    }

    let mut is_prime = vec![true; n + 1];
    is_prime[0] = false;
    is_prime[1] = false;
    for i in 2..=n {
        if is_prime[i] {
            if i * i <= n {
                let mut j = i * i;
                while j <= n {
                    is_prime[j] = false;
                    j += i;
                }
            }
        }
    }
    is_prime
        .iter()
        .enumerate()
        .filter(|(_, &v)| v)
        .map(|(i, _)| i)
        .collect()
}
