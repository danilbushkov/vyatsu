use std::collections::HashMap;

const TABLE: [[char; 6]; 6] = [
    ['А', 'Б', 'В', 'Г', 'Д', 'Е'],
    ['Ё', 'Ж', 'З', 'И', 'Й', 'К'],
    ['Л', 'М', 'Н', 'О', 'П', 'Р'],
    ['С', 'Т', 'У', 'Ф', 'Х', 'Ц'],
    ['Ч', 'Ш', 'Щ', 'Ъ', 'Ы', 'Ь'],
    ['Э', 'Ю', 'Я', '.', ' ', ','],
];

#[derive(Copy, Clone)]
pub struct Crd {
    pub x: usize,
    pub y: usize,
}

pub fn decrypt_from_str(st: &str) -> String {
    let mut crds = vec![];
    let mut c = 0;
    let mut crd = Crd { x: 0, y: 0 };
    for ch in st.chars() {
        if ch != ' ' && ch != '\n' {
            if c == 0 {
                crd.y = (ch as u8 - '0' as u8) as usize;
            } else if c == 1 {
                crd.x = (ch as u8 - '0' as u8) as usize;
            }
            c += 1;
            if c == 2 {
                crds.push(crd);
                c = 0;
            }
        }
    }
    return decrypt(&crds);
}

pub fn encrypt(text: &str) -> String {
    let mut map = HashMap::new();
    for i in 0..TABLE.len() {
        for j in 0..TABLE[0].len() {
            map.insert(TABLE[i][j], format!("{} {}", i + 1, j + 1));
        }
    }

    let mut result = "".to_owned();

    for ch in text.chars() {
        if let Some(v) = map.get(&ch) {
            result += v;
        }
    }

    result
}

pub fn decrypt(crds: &Vec<Crd>) -> String {
    let mut result = "".to_owned();
    for crd in crds.iter() {
        result.push(TABLE[crd.y - 1][crd.x - 1]);
    }
    return result;
}
