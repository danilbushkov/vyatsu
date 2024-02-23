pub const TASK_SBOX: [[u8; 16]; 8] = [
    [
        13, 17, 19, 13, 13, 14, 17, 15, 15, 17, 15, 13, 15, 16, 18, 15,
    ],
    [
        18, 10, 16, 14, 13, 19, 11, 13, 13, 20, 14, 13, 19, 11, 20, 19,
    ],
    [
        20, 19, 11, 12, 11, 17, 10, 13, 11, 16, 10, 10, 11, 11, 17, 20,
    ],
    [
        11, 11, 12, 15, 11, 12, 12, 12, 15, 11, 14, 14, 20, 10, 13, 10,
    ],
    [
        14, 14, 14, 17, 18, 15, 10, 19, 13, 15, 10, 19, 20, 10, 17, 17,
    ],
    [
        14, 13, 16, 16, 16, 12, 17, 19, 10, 10, 13, 18, 15, 13, 13, 19,
    ],
    [
        13, 17, 17, 11, 17, 20, 10, 18, 18, 10, 15, 14, 15, 14, 16, 11,
    ],
    [
        14, 15, 18, 14, 13, 16, 18, 10, 17, 12, 12, 15, 16, 19, 12, 12,
    ],
];

pub const SBOX: [[u8; 16]; 8] = [
    [12, 4, 6, 2, 10, 5, 11, 9, 14, 8, 13, 7, 0, 3, 15, 1],
    [6, 8, 2, 3, 9, 10, 5, 12, 1, 14, 4, 7, 11, 13, 0, 15],
    [11, 3, 5, 8, 2, 15, 10, 13, 14, 1, 7, 4, 12, 9, 6, 0],
    [12, 8, 2, 1, 13, 4, 15, 6, 7, 0, 10, 5, 3, 14, 9, 11],
    [7, 15, 5, 10, 8, 1, 6, 13, 0, 9, 3, 14, 11, 4, 2, 12],
    [5, 13, 15, 6, 9, 2, 12, 10, 11, 7, 8, 1, 4, 3, 14, 0],
    [8, 14, 2, 5, 6, 9, 1, 12, 15, 4, 11, 0, 13, 10, 3, 7],
    [1, 7, 14, 13, 0, 5, 8, 3, 4, 15, 10, 6, 9, 12, 11, 2],
];

fn blocks_from_bytes(bytes: &[u8]) -> Vec<u64> {
    let mut result = vec![];
    let mut count = 8;
    let mut block: u64 = 0;
    for byte in bytes {
        block = block | ((*byte as u64) << ((count - 1) * 8));
        count -= 1;
        if count == 0 {
            result.push(block);
            //println!("{:064b}", block);
            block = 0;
            count = 8;
        }
    }

    return result;
}

fn bytes_from_blocks(blocks: &Vec<u64>) -> Vec<u8> {
    let mut bytes = vec![];
    let count = 8;
    for block in blocks {
        for i in (0..count).rev() {
            bytes.push((block >> (i * 8)) as u8);
        }
    }

    return bytes;
}
pub fn encrypt(bytes: &[u8], key_blocks: &[u32; 8], sbox: &[[u8; 16]; 8]) -> Vec<u8> {
    let blocks = blocks_from_bytes(bytes);
    let mut cipherblocks = vec![];
    for block in blocks {
        cipherblocks.push(encrypt_block(block, key_blocks, sbox, encription_key_order));
    }

    bytes_from_blocks(&cipherblocks)
}

pub fn decrypt(cipherbytes: &[u8], key_blocks: &[u32; 8], sbox: &[[u8; 16]; 8]) -> Vec<u8> {
    let cipherblocks = blocks_from_bytes(cipherbytes);
    let mut blocks = vec![];
    for block in cipherblocks {
        blocks.push(encrypt_block(block, key_blocks, sbox, decription_key_order));
    }

    bytes_from_blocks(&blocks)
}

fn encrypt_block(
    block: u64,
    key_blocks: &[u32; 8],
    sbox: &[[u8; 16]; 8],
    get_key: fn(idx: usize, key_blocks: &[u32; 8]) -> u32,
) -> u64 {
    let (mut l, mut r) = break_into_halves(block);
    for i in 0..32 {
        (l, r) = round(l, r, get_key(i, key_blocks), sbox);
    }

    ((l as u64) << 32) | (r as u64)
}

fn encription_key_order(idx: usize, key_blocks: &[u32; 8]) -> u32 {
    let mut _i: usize = 0;
    if idx < 24 {
        _i = idx % 8usize;
    } else {
        _i = 7 - (idx % 8usize);
    }
    key_blocks[_i]
}
fn decription_key_order(idx: usize, key_blocks: &[u32; 8]) -> u32 {
    let mut _i: usize = 0;
    if idx < 8 {
        _i = idx;
    } else {
        _i = 7 - (idx % 8usize);
    }
    key_blocks[_i]
}

fn round(a: u32, b: u32, k: u32, sbox: &[[u8; 16]; 8]) -> (u32, u32) {
    let sum = a.wrapping_add(k);
    let mask = 15;
    let mut replaced = 0;
    for i in 0..8 {
        let sbox_node_index = (sum >> (i * 4)) & mask;
        replaced = replaced | (((sbox[i][sbox_node_index as usize] as u32) & mask) << i * 4);
    }
    let shifted = replaced.rotate_left(11);

    (shifted ^ b, a)
}

fn break_into_halves(block: u64) -> (u32, u32) {
    let right = block as u32;
    let left = (block >> 32) as u32;
    (left, right)
}
