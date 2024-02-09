import os
import string

def get_drive_letters():
    available_drive_letters = []
    for letter in string.ascii_uppercase:
        drive_path = letter + ":\\"
        if os.path.exists(drive_path) and letter != "C":
            available_drive_letters.append(letter)
    return available_drive_letters

