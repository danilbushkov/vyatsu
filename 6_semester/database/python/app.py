from widgets.window import Window
from presenter import Presenter

class App:

    def __init__(self, config):
        self.state = 'table'
        self.window = Window(config)
        self.presenter = Presenter(self)

        self.window.menu.table_btn.config(command=self.presenter.show_table)
        self.window.menu.add_btn.config(command=self.presenter.show_form)
        self.window.table_area.delete_btn.config(command=self.presenter.clear_table)
        self.window.table_area.filter.btn.config(command=self.presenter.fill_table)
        



    def run(self):
        self.window.run();




