from tkinter import *
from tkinter import ttk

from tk_client.components.input import Input

class MatrixArea(Frame):

    def __init__(self, parent=None, name=""):
        super().__init__(parent, borderwidth=1, relief=SOLID)

        self.label_name = Label(self, text=name)
        self.label_name.pack(side=TOP)

        
        

        self.label_row = Label(self, text="Кол-во строк:")
        self.label_row.pack()
        self.input_row = Input(self, from_=1, to=5)
        self.input_row.pack(anchor=NW)

        self.label_col = Label(self, text="Кол-во столбцов:")
        self.label_col.pack()
        self.input_col = Input(self, from_=1, to=5)
        self.input_col.pack(anchor=NW)

        
        
        self.btn = Button(self, text="Принять")
        self.btn.pack(anchor=NW)


        self.btn_random = Button(self, text="Заполнить")
        self.btn_random.pack(anchor=NW)
        

        


class Matrix(ttk.Frame):
    def __init__(self, parent=None, n=1, m=1):
        super().__init__(parent, borderwidth=1, relief=SOLID)

        self.inputs = []

        
        for r in range(n):
            for c in range(m):
                btn = ttk.Button(text=f"({r},{c})")
                btn.grid(row=r, column=c)