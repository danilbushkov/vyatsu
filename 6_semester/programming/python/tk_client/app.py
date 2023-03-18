from tkinter import *
from tk_client.view import View
from tk_client.controller import Controller


class App():
    
    def __init__(self):
        self.view = View()
        self.controller = Controller(self.view)

        # self.view.menu.btn_add_area.config(
        #     command=self.controller.show_add_area
        # )
        # self.view.menu.btn_subtract_area.config(
        #     command=self.controller.show_subtract_area
        # )
        # self.view.menu.btn_multiply_area.config(
        #     command=self.controller.show_multiply_area
        # )
        # self.view.menu.btn_multiply_by_number_area.config(
        #     command=self.controller.show_multiply_by_number_area
        # )
        # self.view.menu.btn_transpose_area.config(
        #     command=self.controller.show_transpose_area
        # )

    def run(self):
        self.view.run()


