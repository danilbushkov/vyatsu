

class Presenter:

    def __init__(self, view):
        self.view = view


    def hide_table(self):
        self.view.window.table.frame.pack_forget()
        






