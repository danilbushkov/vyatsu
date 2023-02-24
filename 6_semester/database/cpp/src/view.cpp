
#include <view.h>
#include <iostream>



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

void View::deleteRow() {
    clearTable();
    
    
}

void View::addRow() {
    addRowInTable({"test", "Test", "Test", "test", "test"});
    
    
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
    connect(
        window.addButton, 
        SIGNAL(clicked()), 
        this, 
        SLOT(addRow())
    );
    connect(
        window.deleteButton, 
        SIGNAL(clicked()), 
        this, 
        SLOT(deleteRow())
    );

}

void View::clearTable() {
    int n = window.tableWidget->rowCount();
    for(int i = 0; i < n; i++) {
        window.tableWidget->removeRow(0);
    }

}

void View::addRowInTable(QStringList row) {
    int n = window.tableWidget->rowCount();
    window.tableWidget->insertRow(n);
    for(int i = 0; i < row.size(); i++) {

        window.tableWidget->setItem(n,i, new QTableWidgetItem(row[i]));
    }
    
}
