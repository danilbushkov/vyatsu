from tkinter import *



def Menu(master, config, presenter):
    w = config["menu"]["width"];
    h = config["menu"]["height"];
    menu = Frame(master=master, height=h, width=w, borderwidth=1,relief=SOLID)
    

    # btn1 = Button(master=menu, text="Показать таблицу")
    # btn1.pack(anchor=CENTER, fill=X, side=TOP)

    # btn2 = Button(master=menu, text="Добавить строку")
    # btn2.pack(anchor=CENTER, fill=X)

    menu.pack(anchor=NW)

    