from tkinter import *
from widgets.menu import Menu
from widgets.table_area import TableArea
from widgets.update_form import UpdateForm
from widgets.form import Form



class Window:
    def __init__(self, config):
        self.root = Tk()
        self.setup(config)
        
        self.menu = Menu(self.root, config)
        self.table_area = TableArea(self.root, config)
        self.form = Form(self.root, config)
        self.update_form = UpdateForm(self.root, config)
        self.error_label = Label(master = self.root, foreground="red", text="")

        self.menu.pack()
        self.error_label.pack(side = BOTTOM)
        self.table_area.pack()
        
        

        

    def setup(self, config):
        self.root.title(config["window"]["title"])
        self.root.geometry(str(config["window"]["width"])+"x"+str(config["window"]["height"]))
        self.root.resizable(False, False)



    def run(self):
        self.root.mainloop();