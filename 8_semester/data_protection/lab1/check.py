import drive_letter
import config
import os
import bcrypt
import uuid

def get_hashes():
    lines = []

    if not os.path.exists(config.hash_filename):
        return []
    try:
        file = open(config.hash_filename, "r")
        for line in file:
            lines.append(line.strip())
    except:
        raise Exception("Ошибка считывания файла с хэшами")
    finally:
        file.close()  
    return lines


def check():
    letters = drive_letter.get_drive_letters()
    hashes = get_hashes()
    mac = uuid.getnode().to_bytes(8, byteorder='big', signed=True)
    for letter in letters:
        filename = letter+":\\"+config.psw_filename
        if os.path.exists(filename):
            try:
                file = open(filename, "r")
                psw = file.readline()
                
                for hash in hashes:
                    if bcrypt.checkpw(psw.encode()+mac, hash.encode()):
                        return True 
            finally:
                file.close()

    return False

