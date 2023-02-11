from widgets.window import Window
from presenter import Presenter

class App:

    def __init__(self, config):
        self.state = 'table'
        self.window = Window(config)
        self.presenter = Presenter(self)

        self.window.menu.table_btn.config(command=self.presenter.show_table)
        self.window.menu.add_btn.config(command=self.presenter.show_form)
        
        



    def run(self):
        self.window.run();




