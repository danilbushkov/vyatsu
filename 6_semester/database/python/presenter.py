from model import Model


class Presenter:

    def __init__(self, view, db):
        self.view = view
        self.model = Model(db)

        self.fill_table()

####areas
    def show_form(self):
        if self.view.state != 'form':
            self.view.state = 'form'
            self.view.window.table_area.unpack()
            self.view.window.update_form.unpack()
            self.view.window.form.pack()
            



    def show_table(self):
        if self.view.state != 'table' :
            self.view.state = 'table'
            self.view.window.form.unpack()
            self.view.window.update_form.unpack()
            self.view.window.table_area.pack()
            


    def show_update_form(self):
        if self.view.state != 'update' :
            self.view.state = 'update'
            self.view.window.form.unpack()
            self.view.window.table_area.unpack()
            self.view.window.update_form.pack()
            


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


    def fill_table(self):
        data = self.model.get_subscriptions()
        if data[1]:
            if data[0]:
                self.view.window.table_area.table.insert(data[0])
        else:
            self.view.window.error_label["text"] = "Ошибка заполнения таблицы"
            
        






