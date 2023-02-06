from tkinter import *
from widgets.menu import Menu


class Window:
    def __init__(self, config, presenter):
        self.root = Tk()
        self.setup(config)
        
        Menu(self.root, config, presenter)
        

    def setup(self, config):
        self.root.title(config["window"]["title"])
        self.root.geometry(str(config["window"]["width"])+"x"+str(config["window"]["height"]))
        self.root.resizable(False, False)



    def run(self):
        self.root.mainloop();