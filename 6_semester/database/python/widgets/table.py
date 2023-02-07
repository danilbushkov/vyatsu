from tkinter import *



class Table:
    def __init__(self, master, config):
        w = 100
        h = 100
        self.frame = Frame(master=master, height=h, width=w, borderwidth=1,relief=SOLID)
        
        
        pass


    def pack(self):
        self.frame.pack(side=RIGHT, fill=BOTH)