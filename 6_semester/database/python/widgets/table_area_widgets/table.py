from tkinter import *
from tkinter import ttk


class Table:
    def __init__(self, master, config):
        # w = 100
        # h = 100
        self.frame = Frame(master=master, borderwidth=1,relief=SOLID)
        
        
        columns = ("id" ,"name", "cost", "num_trainings", "gym")

        self.tree = ttk.Treeview(master=self.frame, columns=columns, show="headings")
        self.tree.pack(fill=BOTH, side=LEFT)

        self.tree.heading("id", text="Id")
        self.tree.heading("name", text="Название абонемента")
        self.tree.heading("cost", text="Цена")
        self.tree.heading("num_trainings", text="Количество тренировок")
        self.tree.heading("gym", text="Зал")

        self.tree.column(column="#1", width=150)
        self.tree.column(column="#2", width=150)
        self.tree.column(column="#3", width=150)
        self.tree.column(column="#4", width=150)
        self.tree.column(column="#5", width=150)

        self.scrollbar = ttk.Scrollbar(master=self.frame, orient=VERTICAL, command=self.tree.yview)
        self.tree.configure(yscroll=self.scrollbar.set)
        self.scrollbar.pack(side=RIGHT, fill=Y)


    def insert(self, subscriptions):
        for subscription in subscriptions:
            self.tree.insert("", END, values=subscription)

    


    def pack(self):
        self.frame.pack(side=TOP, anchor=NE, fill=BOTH)