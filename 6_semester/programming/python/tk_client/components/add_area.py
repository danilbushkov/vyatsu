import xmlrpc.client
from tkinter import *
from tk_client.components.matrix import MatrixArea, ResultMatrix
from tk_client.config import uri

class AddArea(Frame):

    def __init__(self, parent=None):
        super().__init__(master=parent, borderwidth=1, relief=SOLID)

        row = 4
        col = 3

        for c in range(row): self.columnconfigure(index=c, weight=1)
        for r in range(col): self.rowconfigure(index=r, weight=1)
        
        
        self.label_name = Label(master=self, text="Сложение матриц")
        self.label_name.grid(row=0, column=0, columnspan=col)

        self.matrix_area1 = MatrixArea(self, "Матрица 1")
        self.matrix_area1.grid(row=1, column=0)

        self.matrix_area2 = MatrixArea(self, "Матрица 2")
        self.matrix_area2.grid(row=1, column=1)

        self.result_matrix = ResultMatrix(self)
        self.result_matrix.grid(row=1, column=2)

        self.btn = Button(self, text="Сложить", command=self.add)
        self.btn.grid(row=2, column = 0, columnspan=col)

        self.label_error = Label(self, text="", foreground="red")
        self.label_error.grid(row=3, column = 0, columnspan=col)


    def add(self):
        self.label_error["text"]=""
        m1 = self.matrix_area1.get_matrix()
        m2 = self.matrix_area2.get_matrix()

        n = len(m1)
        m = 0
        if n > 0:
            m = len(m1[0])

        if n > 0 and m > 0 and len(m2) == n and len(m2[0])==m:
            with xmlrpc.client.ServerProxy(uri) as proxy:
                result = proxy.add(m1, m2)
                self.result_matrix.clear_matrix()
                self.result_matrix.create_matrix(result)
        else:
            self.label_error["text"]="Размеры матриц не совпадают"

    