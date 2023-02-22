package lab3;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;

public class Window extends JFrame {
    
    
    private JButton button;
    private Controller controller;
    private JLabel label;

    Window(Controller controller) {
        this.controller = controller;
          
        this.button = new JButton("click"); 
        this.button.setBounds(130,100,100, 40);
        this.button.addActionListener(this.controller.test());

        this.label = new JLabel("");
        this.label.setBounds(100, 100, 100, 100);


                
        this.add(this.button);
        this.add(this.label);
                
        this.setSize(400,500);
        this.setLayout(null);
        this.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
    }

    public void setTextInLabel(String str) {
        this.label.setText(str);
    }



}



