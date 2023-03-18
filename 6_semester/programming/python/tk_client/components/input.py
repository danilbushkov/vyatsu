from tkinter import *

def change():
    print("change")

class Input(Spinbox):

    def __init__(self, parent=None, from_=-100.0, to=100.0):
        self.from_ = int(from_)
        self.to = int(to)
        self.present_value = 0
        self.val = StringVar(value=self.present_value)

        super().__init__(parent, from_=from_, to=to, width=4, textvariable=self.val)
        
        self.val.trace_add("write", self.change)
        

    def change(self, *args):
        val = self.val.get()
        if val == "":
            self.val.set(0)
        elif self.is_int(val):
            if int(val) < self.from_:
                self.val.set(self.from_)
            elif int(val) > self.to:
                self.val.set(self.to)
        else:
            self.val.set(self.present_value)
        self.present_value = self.val.get()


    def is_int(self, n):
        try:
            if n == "-0":
                return False
            if len(n) > 1 and n[0] == "0":
                return False
            return int(n) == float(n)
        except ValueError:
            return False

