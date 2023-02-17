

class Presenter:

    def __init__(self, view):
        self.view = view

####areas
    def show_form(self):
        if self.view.state != 'form':
            self.view.window.table_area.unpack()
            self.view.window.update_form.unpack()
            self.view.window.form.pack()
            self.view.state = 'form'



    def show_table(self):
        if self.view.state != 'table' :
            self.view.window.form.unpack()
            self.view.window.update_form.unpack()
            self.view.window.table_area.pack()
            self.view.state = 'table'

    def show_update_form(self):
        if self.view.state != 'update' :
            self.view.window.form.unpack()
            self.view.window.table_area.unpack()
            self.view.window.update_form.pack()
            self.view.state = 'update'


####

####subscription

    def add_subscription():
        pass

    def delete_subscription():
        pass

    def update_subscription():
        pass
    
####
####filter
    def cancel_filter():
        pass

    def apply_filter():
        pass


####


####

    def clear_table(self):
        self.view.window.table_area.table.clear()


    # def fill_table(self):
    #     subscriptions = [
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (1,"Обычный", 100, 10, "Gym1"),
    #         (2,"Обычный", 100, 10, "Gym1"),
    #         ]
    #     self.view.window.table_area.table.insert(subscriptions)






