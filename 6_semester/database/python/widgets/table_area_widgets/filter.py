from tkinter import *


class Filter:

    def __init__(self, master, config):

        self.frame = Frame(master=master)
        self.filter_frame = Frame(master=self.frame)


        self.label_from = Label(master = self.filter_frame, text="Цена от")
        self.bottom = Entry(master = self.filter_frame)
        self.top = Entry(master = self.filter_frame)
        self.label_to = Label(master = self.filter_frame, text="до")
        self.apply_btn = Button(master = self.filter_frame, text="Применить")

        self.cancel_btn = Button(master = self.frame, text="Отменить")
        
        
        

    def pack(self):
        
        self.label_from.pack(side=LEFT)
        self.bottom.pack(side=LEFT)
        self.label_to.pack(side=LEFT)
        self.top.pack(side=LEFT)
        self.apply_btn.pack(side=LEFT)
        self.filter_frame.pack(anchor=NW)
        
        self.cancel_btn.pack(anchor=NE)
        

        

        self.frame.pack(padx=10, pady=10)