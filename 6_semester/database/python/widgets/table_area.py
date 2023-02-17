from tkinter import *
from widgets.table_area_widgets.table import Table
from widgets.table_area_widgets.filter import Filter




class TableArea:

    def __init__(self, master, config):
        w = 100
        h = 100
        self.frame = Frame(master=master, height=h, width=w)
        self.table = Table(self.frame, config)
        self.filter = Filter(self.frame, config)
        self.delete_btn = Button(master=self.frame, 
                            text="Удалить абонемент")
        self.update_btn = Button(master=self.frame, 
                            text="Изменить абонемент")
        
        


        self.table.pack()
        self.delete_btn.pack(side=LEFT, anchor=NW, padx=10, pady=10)
        self.update_btn.pack(anchor=NW, padx=10, pady=10)
        self.filter.pack()
        
        
        


    def pack(self):
        self.frame.pack(side=RIGHT, fill=BOTH)


    def unpack(self):
        self.frame.pack_forget()