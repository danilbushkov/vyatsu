package lab3;

import javax.swing.JFrame;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class Controller {
    Window view;
    
    Controller() {}

    public void setView(Window window) {
        this.view = window;
    }


    public ActionListener test() {
        return new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                view.setTextInLabel(e.toString());
            }
        };
    }


    
}
