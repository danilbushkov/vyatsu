from tkinter import *



class Menu(Frame):
    def __init__(self, parent=None):       
        super().__init__(parent, borderwidth=1, relief=SOLID)

        self.btn_add_area = Button(master=self, text="Сложить")
        self.btn_add_area.pack(fill=X)

        self.btn_subtract_area = Button(master=self, text="Вычесть")
        self.btn_subtract_area.pack(fill=X)

        self.btn_multiply_by_number_area = Button(master=self, text="Умножить на число")
        self.btn_multiply_by_number_area.pack(fill=X)

        self.btn_multiply_area = Button(master=self, text="Умножить")
        self.btn_multiply_area.pack(fill=X)

        self.btn_transpose_area = Button(master=self, text="Транспонировать")
        self.btn_transpose_area.pack(fill=X)
        
    

