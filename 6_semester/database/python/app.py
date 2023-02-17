from widgets.window import Window
from presenter import Presenter
from database import DataBase

class App:

    def __init__(self, config):
        self.state = 'table'
        self.database = DataBase()
        self.window = Window(config)

        if not self.database.connect(config):
            self.window.error_label["text"] = "Ошибка подлючения"

        self.presenter = Presenter(self, self.database)

        self.window.menu.table_btn.config(command=self.presenter.show_table)
        self.window.menu.add_btn.config(command=self.presenter.show_form)
        self.window.form.add_btn.config(command=self.presenter.add_subscription)
        self.window.table_area.delete_btn.config(command=self.presenter.delete_subscription)
        self.window.table_area.filter.apply_btn.config(command=self.presenter.apply_filter)
        self.window.table_area.filter.cancel_btn.config(command=self.presenter.cancel_filter)
        self.window.table_area.update_btn.config(command=self.presenter.show_update_form)
        self.window.update_form.update_btn.config(command=self.presenter.update_subscription)
        



    def run(self):
        self.window.run()
        self.database.close()





