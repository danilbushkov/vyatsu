from tkinter import *
from tkinter import ttk

from tk_client.components.input import Input

class MatrixArea(Frame):

    def __init__(self, parent=None, name=""):
        super().__init__(parent, borderwidth=1, relief=SOLID)


        row = 3
        col = 1

        for c in range(row): self.columnconfigure(index=c, weight=1)
        for r in range(col): self.rowconfigure(index=r, weight=1)
        
        

        self.label_name = Label(self, text=name)
        self.label_name.grid(row=0, column=0)

        self.matrix = Matrix(self, n=3, m=3)
        self.matrix.grid(row=1, column=0)
        
        self.matrix_setting = MatrixSetting(self)
        self.matrix_setting.grid(row=2, column=0)
        

        


class Matrix(Frame):
    def __init__(self, parent=None, n=1, m=1):
        super().__init__(parent, borderwidth=1, relief=SOLID)


        for c in range(5): self.columnconfigure(index=c, weight=1)
        for r in range(5): self.rowconfigure(index=r, weight=1)
        

        self.inputs = []

        self.fill_matrix(n, m)
        


    def fill_matrix(self, n, m):
        for r in range(n):
            self.inputs.append([])
            for c in range(m):
                btn = Input(self, from_=-100, to=100)
                btn.grid(row=r, column=c)
                self.inputs[r].append(btn)


    def clear_matrix(self):
        n = len(self.inputs)
        m = 0
        if n > 0:
            m = len(self.inputs[0])


        for i in range(n):
            for j in range(m):
                self.inputs[i][j].destroy()

        self.inputs=[]

    def get_matrix(self):
        n = len(self.inputs)
        m = 0
        if n > 0:
            m = len(self.inputs[0])

        matrix = []
        for i in range(n):
            matrix.append([])
            for j in range(m):
                matrix[i].append(int(self.inputs[i][j]))
        
        return matrix


class MatrixSetting(ttk.Frame):
    def __init__(self, parent=None, accept_command=None, fill_command=None):
        super().__init__(parent, borderwidth=0, relief=SOLID)


        row = 3
        col = 2

        for c in range(row): self.columnconfigure(index=c, weight=1)
        for r in range(col): self.rowconfigure(index=r, weight=1)
        
        

        

        self.label_row = Label(self, text="Кол-во строк(max:5):")
        self.label_row.grid(row=0, column=0)
        self.input_row = Input(self, from_=1, to=5)
        self.input_row.grid(row=0, column=1)

        self.label_col = Label(self, text="Кол-во столбцов(max:5):")
        self.label_col.grid(row=1, column=0)
        self.input_col = Input(self, from_=1, to=5)
        self.input_col.grid(row=1, column=1)

        
        
        self.btn = Button(self, text="Принять", command=accept_command)
        self.btn.grid(row=2, column=0)


        self.btn_random = Button(self, text="Заполнить", command=fill_command)
        self.btn_random.grid(row=2, column=1)
        

    def get_number_of_row(self):
        return int(self.input_row.get())

    def get_number_of_column(self):
        return int(self.input_col.get())