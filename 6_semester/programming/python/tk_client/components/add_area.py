from tkinter import *
from tk_client.components.matrix import Matrix

class AddArea(Frame):

    def __init__(self, parent=None):
        super().__init__(master=parent, borderwidth=1, relief=SOLID)

        self.label_name = Label(master=self, text="Сложение матриц")
        self.label_name.pack(anchor=N, side=TOP)

        self.matrix1 = Matrix(self, "Матрица 1")
        self.matrix1.pack(anchor=NW, side=LEFT)




    