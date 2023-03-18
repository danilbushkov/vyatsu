from tkinter import *
from tk_client.components.input import Input

class Matrix(Frame):

    def __init__(self, parent=None, name=""):
        super().__init__(parent, borderwidth=1, relief=SOLID)

        self.label_name = Label(self, text=name)
        self.label_name.pack(side=TOP)

        self.input = Input(self, from_=-100.0, to=100.0)
        self.input.pack(anchor=NW)
        self.input = Input(self, from_=-100.0, to=100.0)
        self.input.pack(anchor=NW)

        