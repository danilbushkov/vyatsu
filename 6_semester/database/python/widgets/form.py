from tkinter import *
from tkinter import ttk

class Form:

    def __init__(self, master, config):

        self.frame = Frame(master=master)

        self.label_form = Label(master = self.frame, text="Форма добавления")
        self.label_name = Label(master = self.frame, text="Название абонемента")
        self.label_cost = Label(master = self.frame, text="Цена абонемента")
        self.label_num_trainings = Label(master = self.frame, text="Количество тренировок")
        self.label_gym = Label(master = self.frame, text="Выберите зал:")
        
        self.name_input = Entry(master = self.frame)
        self.cost_input = Entry(master = self.frame)
        self.trainings_input = Entry(master = self.frame)
        self.gyms = ttk.Combobox(master = self.frame, state="readonly")

        
        self.add_btn = Button(master = self.frame, text="Добавить абонемент")

        

        self.label_form.pack(anchor=NW, ipady=20)
        self.label_name.pack(anchor=NW)
        self.name_input.pack(anchor=NW)
        self.label_cost.pack(anchor=NW)
        self.cost_input.pack(anchor=NW)
        self.label_num_trainings.pack(anchor=NW)
        self.trainings_input.pack(anchor=NW)        
        self.label_gym.pack(anchor=NW)
        self.gyms.pack(anchor=NW, pady=6)
        self.add_btn.pack(anchor=NW)
        
        

    
        
        
        

        
    def pack(self):
        self.frame.pack(padx=10, pady=10, anchor=CENTER)

    def unpack(self):
        self.frame.pack_forget()