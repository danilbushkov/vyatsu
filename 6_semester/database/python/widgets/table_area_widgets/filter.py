from tkinter import *


class Filter:

    def __init__(self, master, config):

        self.frame = Frame(master=master)
        self.filter_frame = Frame(master=self.frame)


        self.label_from = Label(master = self.filter_frame, text="Цена от")
        self.bottom = Entry(master = self.filter_frame)
        self.top = Entry(master = self.filter_frame)
        self.label_to = Label(master = self.filter_frame, text="до")
        self.btn = Button(master = self.filter_frame, text="Применить")
        self.error_label = Label(master = self.frame, foreground="red", text="")
        
        

    def pack(self):
        
        self.label_from.pack(side=LEFT)
        self.bottom.pack(side=LEFT)
        self.label_to.pack(side=LEFT)
        self.top.pack(side=LEFT)
        self.btn.pack(side=LEFT)
        self.filter_frame.pack(anchor=NW)
        self.error_label.pack(anchor=NW)

        

        self.frame.pack(padx=10, pady=10)