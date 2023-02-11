from tkinter import *
from widgets.menu import Menu
from widgets.table_area import TableArea
from widgets.form import Form



class Window:
    def __init__(self, config):
        self.root = Tk()
        self.setup(config)
        
        self.menu = Menu(self.root, config)
        self.table_area = TableArea(self.root, config)
        self.form = Form(self.root, config)
        
        self.table_area.pack()
       
        self.menu.pack()
        #self.form.pack()

        

    def setup(self, config):
        self.root.title(config["window"]["title"])
        self.root.geometry(str(config["window"]["width"])+"x"+str(config["window"]["height"]))
        self.root.resizable(False, False)



    def run(self):
        self.root.mainloop();