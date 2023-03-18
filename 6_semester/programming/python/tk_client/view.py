from tkinter import *
from tk_client.components.menu import Menu
from tk_client.components.add_area import AddArea

class View(Tk):
    
    def __init__(self):
        super().__init__()

        self.menu = Menu(self)
        self.add_area = AddArea(self)

        self.geometry("700x600")
        self.title("Операции над матрицами")
        self.resizable(False, False)

        
        self.menu.pack(anchor=NW, side=LEFT, fill=Y)
        self.add_area.pack(anchor=NW, side=LEFT, fill=BOTH, expand=True)

    def run(self):
        self.mainloop()