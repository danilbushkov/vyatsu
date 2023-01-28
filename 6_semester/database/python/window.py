from tkinter import *
from config import config
from menu import menu


def run():
    root = Tk()
    setup(root, config)
    add(root, config)
    root.mainloop()


def setup(root, config):
    root.title("Hello")
    root.geometry(str(config["window"]["width"])+"x"+str(config["window"]["height"]))
    root.resizable(False, False)

    

def add(root, config):
    menu(root, config)



