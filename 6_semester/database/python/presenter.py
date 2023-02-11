

class Presenter:

    def __init__(self, view):
        self.view = view


    def show_form(self):
        if self.view.state != 'form':
            self.view.window.table_area.unpack()
            self.view.window.form.pack()
            self.view.state = 'form'



    def show_table(self):
        if self.view.state != 'table' :
            self.view.window.form.unpack()
            self.view.window.table_area.pack()
            self.view.state = 'table'

    def clear_table(self):
        self.view.window.table_area.table.clear()


    def fill_table(self):
        subscriptions = [
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (1,"Обычный", 100, 10, "Gym1"),
            (2,"Обычный", 100, 10, "Gym1"),
            ]
        self.view.window.table_area.table.insert(subscriptions)






