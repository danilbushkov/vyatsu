from widgets.window import Window
from presenter import Presenter

class App:

    def __init__(self, config):
        
        self.window = Window(config)
        self.presenter = Presenter(self)

        self.window.menu.table_btn.config(command=self.presenter.hide_table)

        
        



    def run(self):
        self.window.run();




