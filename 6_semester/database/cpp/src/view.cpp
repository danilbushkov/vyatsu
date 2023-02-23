
#include <view.h>



void View::viewTable() {
    if(state != "table") {
        state = "table";
        window.addArea->setVisible(false);
        window.tableArea->setVisible(true);
    }
}

void View::viewUpdateForm() {
    if(state != "update") {
        state = "update";
        window.label1->setText("Изменение");
        window.addArea->setVisible(true);
        window.tableArea->setVisible(false);
        window.addButton->setVisible(false);
        window.updateButton->setVisible(true);

    }
    
    
}

void View::viewAddForm() {
    if(state != "add") {
        state = "add";
        window.label1->setText("Добавление");
        window.addArea->setVisible(true);
        window.tableArea->setVisible(false);
        window.addButton->setVisible(true);
        window.updateButton->setVisible(false);
    }
    
    
}



void View::bindHandlers() {
    connect(
        window.formButton, 
        SIGNAL(clicked()), 
        this, 
        SLOT(viewAddForm())
    );
    connect(
        window.tableButton, 
        SIGNAL(clicked()), 
        this, 
        SLOT(viewTable())
    );
    connect(
        window.updateFormButton, 
        SIGNAL(clicked()), 
        this, 
        SLOT(viewUpdateForm())
    );



}
