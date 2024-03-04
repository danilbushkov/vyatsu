pub const TASK1_TEXT: &'static str = "Задание:
Напишите дешифратор для <<ШИФРА КВАДРАТ ПОЛИБИЯ>> и расшифруйте
предоставленную строку:

3 25 56 51 36 53 44 21 31 64 21 66 52 31 16 54 21 64 56
66 52 63 41 43 46 53 53 62 43 64 35 12 43 12 46 4

Квадрат для расшифровки (размерность 6х6, строки разделены запятой):
АБВГДЕ, ЁЖЗИЙК, ЛМНОПР, СТУФХЦ, ЧШЩЪЫЬ, ЭЮЯ. ,";

pub const TASK1_STR: &'static str = "3 25 56 51 36 53 44 21 31 64 21 66 52 31 16 54 21 64 56 66 52 63 41 43 46 53 53 62 43 64 35 12 43 12 46 4";

pub const TASK2_TEXT: &'static str = "Алгоритм шифрования ГОСТ 28147-89
Зашифруйте строку: <<Учитесь у всех — не подражайте никому.>>
Алгоритмом шифрования ГОСТ 28147-89 в режиме простой замены.
Ключ для шифрования:

5870656714305741314204151337666714747979980475501584019902432263

Используйте узлы замены:
13 18 20 11 14 14 13 14
17 10 19 11 14 13 17 15
19 16 11 12 14 16 17 18
13 14 12 15 17 16 11 14
13 13 11 11 18 16 17 13
14 19 17 12 15 12 20 16
17 11 10 12 10 17 10 18
15 13 13 12 19 19 18 10
15 13 11 15 13 10 18 17
17 20 16 11 15 10 10 12
15 14 10 14 10 13 15 12
13 13 10 14 19 18 14 15
15 19 11 20 20 15 15 16
16 11 11 10 10 13 14 19
18 20 17 13 17 13 16 12
15 19 20 10 17 19 11 12";

pub const TASK2_STR: &'static str = "Учитесь у всех — не подражайте никому.";
pub const TASK2_KEY: &'static [u8; 64] =
    b"5870656714305741314204151337666714747979980475501584019902432263";

pub const TASK3_TEXT: &'static str = "Алгоритм шифрования rsa.
Сгенерируйте открытый и закрытый ключи в алгоритме шифрования RSA, выбрав
простые числа p = 659 и q = 599.
Зашифруйте сообщение: Счастливые часов не наблюдают.";
