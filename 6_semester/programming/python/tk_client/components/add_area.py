from tkinter import *
from tk_client.components.matrix import MatrixArea

class AddArea(Frame):

    def __init__(self, parent=None):
        super().__init__(master=parent, borderwidth=1, relief=SOLID)

        row = 100
        col = 100

        for c in range(row): self.columnconfigure(index=c, weight=1)
        for r in range(col): self.rowconfigure(index=r, weight=1)
        
        
        self.label_name = Label(master=self, text="Сложение матриц")
        self.label_name.grid(row=0, column=0, columnspan=col)

        self.matrix_area1 = MatrixArea(self, "Матрица 1")
        self.matrix_area1.grid(row=0, column=0, columnspan=col, rowspan=row)





    