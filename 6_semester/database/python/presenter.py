from model import Model
from tkinter import *
from tkinter.messagebox import askyesno


class Presenter:

    def __init__(self, view, db):
        self.view = view
        self.model = Model(db)
        self.gyms_id = {}

        self.fill_table()
        self.add_values_in_combobox()


####areas
    def show_form(self):
        if self.view.state != 'form':
            self.view.state = 'form'
            self.view.window.table_area.unpack()
            self.view.window.update_form.unpack()
            self.view.window.form.pack()
            self.view.window.error_label["text"]=""
            



    def show_table(self):
        if self.view.state != 'table' :
            self.view.state = 'table'
            self.view.window.form.unpack()
            self.view.window.update_form.unpack()
            self.view.window.table_area.pack()
            self.view.window.error_label["text"]=""
            


    def show_update_form(self):
        count = len(self.view.window.table_area.table.get_selection())
        if count > 0 and self.view.state != 'update' :
            self.view.state = 'update'
            self.view.window.form.unpack()
            self.view.window.table_area.unpack()
            self.view.window.update_form.pack()
            self.view.window.error_label["text"]=""
            self.fill_update_form()
        else:
            self.view.window.error_label["text"] = "Не выбран элемент"
            


####

####subscription

    def add_subscription(self):
        self.view.window.error_label["text"] = ""
        name = self.view.window.form.name_input.get().strip()
        cost = self.view.window.form.cost_input.get().strip()
        num_trainings = self.view.window.form.trainings_input.get().strip()
        gym = self.view.window.form.gyms.get().strip()
        subscription = (name, cost, num_trainings, gym)
        if self.check_subscription(subscription):
            subscription = (name, cost, num_trainings, self.gyms_id[gym])
            if self.model.add_subscription(subscription):
                self.clear_table()
                self.fill_table()
                self.show_table()
            else:
                self.view.window.error_label["text"] = "Ошибка при добавлении абонемента"




    def delete_subscription(self):
        self.view.window.error_label["text"] = ""
        if askyesno(title="Подтвержение операции", message="Удалить запись?"):
            for item in self.view.window.table_area.table.get_selection():
                if not self.model.delete_subscription(item[0]):
                    self.view.window.error_label["text"] = "Ошибка при удалении"
                    break
            self.clear_table()
            self.fill_table()


    def update_subscription(self):
        self.view.window.error_label["text"] = ""
        name = self.view.window.update_form.name_input.get().strip()
        cost = self.view.window.update_form.cost_input.get().strip()
        num_trainings = self.view.window.update_form.trainings_input.get().strip()
        gym = self.view.window.update_form.gyms.get().strip()
        subscription = (name, cost, num_trainings, gym)
        if self.check_subscription(subscription):
            subscription = (name, cost, num_trainings, self.gyms_id[gym], self.id)
            if self.model.update_subscription(subscription):
                self.clear_table()
                self.fill_table()
                self.show_table()
            else:
                self.view.window.error_label["text"] = "Ошибка при изменении абонемента"
    
####
####filter
    def cancel_filter(self):
        self.view.window.error_label["text"] = ""
        self.clear_table()
        self.fill_table()

    def apply_filter(self):
        self.view.window.error_label["text"] = ""
        cost1 = self.view.window.table_area.filter.bottom.get().strip()
        cost2 = self.view.window.table_area.filter.top.get().strip()
        
        filter = (cost1, cost2)
        if self.check_filter(filter):
            self.clear_table()
            self.filter_table(filter)




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


    def filter_table(self, filter):
        data = self.model.get_filter_subscriptions(filter)
        if data[1]:
            if data[0]:
                self.view.window.table_area.table.insert(data[0])
        else:
            self.view.window.error_label["text"] = "Ошибка заполнения таблицы"
            

    def add_values_in_combobox(self):
        data = self.model.get_gyms()
        gyms = []
        if data[1]:
            if data[0]:
                for item in data[0]:
                    gyms.append(item[1])
                    self.gyms_id[item[1]] = item[0]
                    
                self.view.window.form.gyms["values"]=gyms
                self.view.window.update_form.gyms["values"]=gyms
                

        else:
            self.view.window.error_label["text"] = "Ошибка заполнения залов"


    def check_subscription(self, subscription):
        if not subscription[0]:
            self.view.window.error_label["text"] = "Не заполнено имя"
            return False

        if not subscription[1]:
            self.view.window.error_label["text"] = "Не заполнена цена"
            return False

        if not subscription[2]:
            self.view.window.error_label["text"] = "Не заполнено количество тренировок"
            return False

        if not subscription[3]:
            self.view.window.error_label["text"] = "Не заполнен зал"
            return False

        if len(subscription[0]) > 50:
            self.view.window.error_label["text"] = "Длина имени должна быть не больше 50 символов"
            return False
        
        if not subscription[1].isdigit() or int(subscription[1]) > 1000000 or int(subscription[1]) < 0:
            self.view.window.error_label["text"] = "Цена должна быть числом от 0 до 1000000"
            return False

        if not subscription[2].isdigit() or int(subscription[2]) > 1000 or int(subscription[2]) < 0:
            self.view.window.error_label["text"] = "Количество тренировок должно быть числом от 0 до 1000"
            return False

        return True

    def fill_update_form(self):
        item = self.view.window.table_area.table.get_selection()[0]
        if item:
            self.id = item[0]
            self.view.window.update_form.name_input.delete(0, END)
            self.view.window.update_form.cost_input.delete(0, END)
            self.view.window.update_form.trainings_input.delete(0, END)


            self.view.window.update_form.name_input.insert(0, (item[1]))
            self.view.window.update_form.cost_input.insert(0, (item[2]))
            self.view.window.update_form.trainings_input.insert(0, (item[3]))
            self.view.window.update_form.gyms.set(item[4])

    def check_filter(self, filter_data):
        if not filter_data[0].isdigit() or int(filter_data[0]) < 0 or int(filter_data[0]) > 1000000:
            self.view.window.error_label["text"] = "Цена в фильтре должна быть числом от 0 до 1000000"
            return False

        if not filter_data[1].isdigit() or int(filter_data[1]) < 0 or int(filter_data[1]) > 1000000:
            self.view.window.error_label["text"] = "Цена в фильтре должна быть числом от 0 до 1000000"
            return False

        return True
                

