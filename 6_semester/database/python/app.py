from presenter import Presenter
from widgets.window import Window

class App:

    def __init__(self, config):
        self.presenter = Presenter(self)
        self.window = Window(config, self.presenter)



    def run(self):
        self.window.run();