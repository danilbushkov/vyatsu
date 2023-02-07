from tkinter import *
from widgets.menu import Menu
from widgets.form import Form
from widgets.table import Table


class Window:
    def __init__(self, config):
        self.root = Tk()
        self.setup(config)
        
        self.menu = Menu(self.root, config)
        self.table = Table(self.root, config)

        #self.form 
        

        self.table.pack()
        self.menu.pack()
        

    def setup(self, config):
        self.root.title(config["window"]["title"])
        self.root.geometry(str(config["window"]["width"])+"x"+str(config["window"]["height"]))
        self.root.resizable(False, False)



    def run(self):
        self.root.mainloop();