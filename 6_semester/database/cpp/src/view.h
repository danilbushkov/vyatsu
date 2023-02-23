#ifndef VIEW_H
#define VIEW_H

#include <ui.h>
#include <string>

class View: public QMainWindow {
    Q_OBJECT

private:
    Ui::MainWindow window;
    std::string state;
    
public:
    

    View(): QMainWindow() {
        
        state = "table";
        window.setupUi(this);
        window.retranslateUi(this);
        window.addArea->setVisible(false);
        
        bindHandlers();

        
    };

    void bindHandlers();

private slots:
    void viewTable();
    void viewAddForm();
    void viewUpdateForm();




};


#endif