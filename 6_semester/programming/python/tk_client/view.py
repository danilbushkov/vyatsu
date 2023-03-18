from tkinter import *
from tkinter import ttk
from tk_client.components.add_area import AddArea
from tk_client.components.subtract_area import SubtractArea
from tk_client.components.multiply_area import MultiplyArea
from tk_client.components.multiply_num_area import MultiplyNumArea
from tk_client.components.transpose_area import TransposeArea

class View(Tk):
    
    def __init__(self):
        super().__init__()

        self.geometry("800x500")
        self.title("Операции над матрицами")
        self.resizable(False, False)


        self.notebook = ttk.Notebook()
        self.notebook.pack(expand=True, fill=BOTH)

        
        self.add_area = AddArea(self)
        self.add_area.pack(fill=BOTH, expand=True)

        self.subtract_area = SubtractArea(self)
        self.subtract_area.pack(fill=BOTH, expand=True)

        self.multiply_area = MultiplyArea(self)
        self.multiply_area.pack(fill=BOTH, expand=True)

        self.multiply_num_area = MultiplyNumArea(self)
        self.multiply_num_area.pack(fill=BOTH, expand=True)

        self.transpose_area = TransposeArea(self)
        self.transpose_area.pack(fill=BOTH, expand=True)

        self.notebook.add(self.add_area, text="Сложить")
        self.notebook.add(self.subtract_area, text="Вычесть")
        self.notebook.add(self.multiply_area, text="Умножить")
        self.notebook.add(self.multiply_num_area, text="Умножить на число")
        self.notebook.add(self.transpose_area, text="Транспонировать")
        
        

    def run(self):
        self.mainloop()