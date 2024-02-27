use num_bigint::BigInt;

//pub fn new_keys(p: BigInt, q: BigInt) -> ((BigInt, BigInt), (BigInt, BigInt)) {
//    let mut e: BigInt = BigInt::new(vec![0]);
//    let mut n: BigInt = BigInt::new(vec![0]);
//    let mut d: BigInt = BigInt::new(vec![0]);
//    let mut n: BigInt = BigInt::new(vec![0]);
//
//    ((e, n.clone()), (d, n))
//}

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
