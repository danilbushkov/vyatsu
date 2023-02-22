package lab3;




public class GUIApp {

    Window view;
    Controller controller;

    GUIApp() {
        this.controller = new Controller();
        this.view = new Window(controller);
        this.controller.setView(this.view);


    }
    



    public void run() {
        this.view.setVisible(true);
    }





}