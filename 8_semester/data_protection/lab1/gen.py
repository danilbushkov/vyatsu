import drive_letter
import config
import random 
import bcrypt
import uuid

letters = drive_letter.get_drive_letters()
survey = True
while survey:
    print("Выберете место для генерации ключа: ")
    for drive_letter in letters:
        print(drive_letter)
    print()
    print("Для выхода введите exit.")

    selection = input("Выбор: ")
    if selection in set(letters):
        survey = False
    elif selection == "exit":
        exit()
    else: 
        print()
        print("Такого места не существует")
        print()

filepath = selection+":\\"+config.psw_filename
psw = format(random.getrandbits(128), 'x')
mac = uuid.getnode().to_bytes(8, byteorder='big', signed=True)
hash_and_salt = bcrypt.hashpw(psw.encode()+mac, bcrypt.gensalt())


hash_file = open(config.hash_filename, "a")
file = open(filepath, "w")

try:
    hash_file.write(hash_and_salt.decode()+"\n")
    file.write(psw)
except Exception:
    print("Ошибка")
finally:    
    hash_file.close()
    file.close()
