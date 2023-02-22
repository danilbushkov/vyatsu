package lab1;

import javax.swing.JButton;
import javax.swing.JFrame;

public class Window extends JFrame {
    
    
    private JButton button;

    Window() {
        
          
        this.button = new JButton("click"); 
        this.button.setBounds(130,100,100, 40);
                
        this.add(this.button);
                
        this.setSize(400,500);
        this.setLayout(null);
        this.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
    }



}
