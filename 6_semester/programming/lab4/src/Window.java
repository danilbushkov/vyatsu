package lab4;

import java.awt.Container;
import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import java.awt.Component;
import java.awt.GridLayout;
import javax.swing.ButtonGroup;
import javax.swing.JRadioButton;



public class Window extends JFrame {
    
    private JLabel label1;
    private JTextField input1;

    private JLabel label2;
    private JTextField input2;
    
    private JPanel radioPanel;
    private JRadioButton prefix;
    private JRadioButton suffix;
    private JRadioButton substring;
    private JRadioButton subsequence;


    private JButton button;
    private Presenter presenter;
    private JLabel answerLabel;
    

    Window() {
        this.presenter = new Presenter(this);

        int windowWidth = 350;
        int windowHeight = 300;


        this.label1 = new JLabel("Enter first string: ");
        this.label1.setSize(100,10);

        this.input1 = new JTextField(30);
        this.input1.setSize(100,10);

        this.label2 = new JLabel("Enter second string: ");
        this.input2 = new JTextField(30);
        


        this.prefix = new JRadioButton("Second string is Prefix");
        this.prefix.doClick();
        this.suffix = new JRadioButton("Second string is Suffix");
        this.substring = new JRadioButton("Second string is Substring");
        this.subsequence = new JRadioButton("Second string is Subsequence");
        
        this.radioPanel = this.getRadioPanel(
            this.prefix,
            this.suffix,
            this.substring,
            this.subsequence
        );

        this.button = new JButton("Check"); 
        this.button.addActionListener(this.presenter.test());



        this.answerLabel = new JLabel("");

        
        Container container = this.getContentPane();
        container.setLayout(new BoxLayout(container, BoxLayout.Y_AXIS));

      
        container.add(this.createGrid(
            2, 2,
            label1,
            input1,
            label2,
            input2
        ));
        container.add(this.radioPanel);
        container.add(this.createGrid( 
            2, 1,
            this.button,
            this.answerLabel
        ));
        
                
        this.setTitle("Lab3");
        this.setSize(windowWidth, windowHeight);
        this.setResizable(false);
        this.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        
    }

    private Component createGrid(int rows, int cols, Component ...components) {
        Container container = new Container();
        container.setLayout(new GridLayout(rows, cols, 0, 0));
        for(Component component: components) {
            container.add(component);
        }
        return container;
    }

    private JPanel getRadioPanel(JRadioButton ...radioButtons) {
        JPanel panel = new JPanel(new GridLayout(0, 1, 0, 5));
        ButtonGroup buttonGroup = new ButtonGroup();
        panel.setBorder(BorderFactory.createTitledBorder("Mode"));
        for(JRadioButton radioButton: radioButtons) {
            panel.add(radioButton);
            buttonGroup.add(radioButton);
        }

        
        
        return panel;
    }

    public void setTextInAnswer(String str) {
        this.answerLabel.setText(str);
    }

    public String getFirstString() {
        return this.input1.getText().trim();
    }
    public String getSecondString() {
        return this.input2.getText().trim();
    }

    public int getRadioNumber() {
        if(this.suffix.isSelected()) {
            return 1;
        }
        if(this.substring.isSelected()) {
            return 2;
        }
        if(this.subsequence.isSelected()) {
            return 3;
        }

        return 0;
    }

    public void run() {
        this.setVisible(true);
    }

}



