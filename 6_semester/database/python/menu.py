from tkinter import *
from config import config

def menu(master, config):
    setup(master, config)
    


def setup(master, config):
    w = config["menu"]["width"];
    h = config["menu"]["height"];
    menu = Frame(master=master, height=h, width=w, borderwidth=1,relief=SOLID)
    menu.pack(anchor=NW)