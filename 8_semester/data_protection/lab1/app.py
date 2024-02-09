import drive_letter
from check import check

try:
    if check():
        print("Приложение успешно запустилось")
    else:
        print("Ошибка доступа")

except Exception as e:
    print(e)

