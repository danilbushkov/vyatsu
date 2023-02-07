from tkinter import *




    # btn1 = Button(master=menu, text="Показать таблицу")
    # btn1.pack(anchor=CENTER, fill=X, side=TOP)

    # btn2 = Button(master=menu, text="Добавить строку")
    # btn2.pack(anchor=CENTER, fill=X)

    


class Menu:

    def __init__(self, master, config):
        w = config["menu"]["width"]
        h = config["menu"]["height"]

        self.frame = Frame(master=master, height=h, width=w, borderwidth=1,relief=SOLID)
        self.table_btn = Button(master=self.frame, 
                            text="Показать таблицу")
        self.add_btn = Button(master=self.frame, 
                            text="Добавить строку")




    def pack(self):
        self.table_btn.pack(anchor=CENTER, fill=X, side=TOP)
        self.add_btn.pack(anchor=CENTER, fill=X, side=TOP)
        self.frame.pack(side=LEFT, fill=BOTH)


    