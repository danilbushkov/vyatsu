mod sboxes;

use sboxes::{T1, T2, T3, T4};

const A: u64 = 0x0123456789ABCDEF;
const B: u64 = 0xFEDCBA9876543210;
const C: u64 = 0xF096A5B4C3B2E187;

pub fn hash(bytes: &[u8]) -> (u64, u64, u64) {
    let mut a = A;
    let mut b = B;
    let mut c = C;

    let blocks = get_blocks_from_bytes(bytes);
    for block in blocks {
        (a, b, c) = compress(a, b, c, block);
    }
    (a, b, c)
}

pub fn hash_to_hex_string(hash: (u64, u64, u64)) -> String {
    format!("{:X} {:X} {:X}", hash.0, hash.1, hash.2)
}

fn compress(mut a: u64, mut b: u64, mut c: u64, mut x: [u64; 8]) -> (u64, u64, u64) {
    let aa = a;
    let bb = b;
    let cc = c;
    (a, b, c) = pass(a, b, c, x, 5);
    x = key_schedule(x);
    (c, a, b) = pass(c, a, b, x, 7);
    x = key_schedule(x);
    (b, c, a) = pass(b, c, a, x, 9);
    (a ^ aa, b.wrapping_sub(bb), c.wrapping_add(cc))
}

fn pass(mut a: u64, mut b: u64, mut c: u64, x: [u64; 8], mul: u64) -> (u64, u64, u64) {
    (a, b, c) = round(a, b, c, x[0], mul);
    (b, c, a) = round(b, c, a, x[1], mul);
    (c, a, b) = round(c, a, b, x[2], mul);
    (a, b, c) = round(a, b, c, x[3], mul);
    (b, c, a) = round(b, c, a, x[4], mul);
    (c, a, b) = round(c, a, b, x[5], mul);
    (a, b, c) = round(a, b, c, x[6], mul);
    (b, c, a) = round(b, c, a, x[7], mul);
    (a, b, c)
}
fn round(mut a: u64, mut b: u64, mut c: u64, x: u64, mul: u64) -> (u64, u64, u64) {
    c ^= x;

    a = a.wrapping_sub(
        T1[get_byte(c, 0) as usize]
            ^ T2[get_byte(c, 2) as usize]
            ^ T3[get_byte(c, 4) as usize]
            ^ T4[get_byte(c, 6) as usize],
    );
    b = b.wrapping_add(
        T4[get_byte(c, 1) as usize]
            ^ T3[get_byte(c, 3) as usize]
            ^ T2[get_byte(c, 5) as usize]
            ^ T1[get_byte(c, 7) as usize],
    );
    b = b.wrapping_mul(mul);
    (a, b, c)
}

fn key_schedule(mut x: [u64; 8]) -> [u64; 8] {
    x[0] = x[0].wrapping_sub(x[7] ^ 0xA5A5A5A5A5A5A5A5);
    x[1] ^= x[0];
    x[2] = x[2].wrapping_add(x[1]);
    x[3] = x[3].wrapping_sub(x[2] ^ ((!x[1]) << 19));
    x[4] ^= x[3];
    x[5] = x[5].wrapping_add(x[4]);
    x[6] = x[6].wrapping_sub(x[5] ^ ((!x[4]) >> 23));
    x[7] ^= x[6];
    x[0] = x[0].wrapping_add(x[7]);
    x[1] = x[1].wrapping_sub(x[0] ^ ((!x[7]) << 19));
    x[2] ^= x[1];
    x[3] = x[3].wrapping_add(x[2]);
    x[4] = x[4].wrapping_sub(x[3] ^ ((!x[2]) >> 23));
    x[5] ^= x[4];
    x[6] = x[6].wrapping_add(x[5]);
    x[7] = x[7].wrapping_sub(x[6] ^ 0x0123456789ABCDEF);
    x
}

fn get_byte(word: u64, pos: u64) -> u8 {
    (word >> (pos * 8)) as u8
}

fn get_blocks_from_bytes(bytes: &[u8]) -> Vec<[u64; 8]> {
    let len = bytes.len();
    let mut bytes = Vec::from(bytes);
    bytes.push(0x01);

    let mut blocks: Vec<[u64; 8]> = vec![];
    let mut word = 0;
    let mut block: [u64; 8] = [0; 8];
    let mut byte_count = 8;
    let mut current_word = 0;

    let m = bytes.len() % 64;
    let mut _to = 0;
    if m > 56 {
        _to = 128;
    } else {
        _to = 64;
    }
    for _ in m..=_to {
        bytes.push(0);
    }

    for byte in bytes {
        byte_count -= 1;
        word = word | ((byte as u64) << (8 * byte_count));
        if byte_count == 0 {
            byte_count = 8;
            block[current_word] = word;
            word = 0;
            current_word += 1;

            if current_word == 8 {
                current_word = 0;
                blocks.push(block);
                block = [0; 8];
            }
        }
    }
    let i = blocks.len() - 1;
    blocks[i][7] = (len as u64) << 3;
    blocks
}
