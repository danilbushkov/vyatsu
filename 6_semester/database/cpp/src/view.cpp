
#include <view.h>
#include <iostream>



void View::viewTable() {
    if(state != "table") {
        state = "table";
        window.addArea->setVisible(false);
        window.tableArea->setVisible(true);
        window.errorLabel->setText("");
    }
}

void View::viewUpdateForm() {
    
    if(state != "update") {
        QList<QTableWidgetItem *> items = window.tableWidget->selectedItems();
        if(items.size() > 0) {
            state = "update";
            window.label1->setText("Изменение");
            window.addArea->setVisible(true);
            window.tableArea->setVisible(false);
            window.addButton->setVisible(false);
            window.updateButton->setVisible(true);

            id = items.at(0)->data(0).toInt();
            QString name = items.at(1)->data(0).toString();
            QString cost = items.at(2)->data(0).toString();
            QString trainingsCount = items.at(3)->data(0).toString();
            QString gym = items.at(4)->data(0).toString();
            
            window.costEdit->setText(cost);
            window.nameEdit->setText(name);
            window.trainingsInput->setText(trainingsCount);
            window.comboBox->setCurrentText(gym);
            window.errorLabel->setText("");
        } else {
            window.errorLabel->setText("Строка не выбрана!");
        }
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

        window.costEdit->setText("");
        window.nameEdit->setText("");
        window.trainingsInput->setText("");
        window.errorLabel->setText("");
    }
    
    
}

void View::deleteRow() {
    window.errorLabel->setText("");
    QList<QTableWidgetItem *> items = window.tableWidget->selectedItems();
    if(items.size() > 0) {
        QMessageBox msgBox;
        msgBox.setText("Удаление.");
        msgBox.setInformativeText("Вы уверены, что хотите удалить строку?");
        
        msgBox.addButton(QString("Отмена"), QMessageBox::NoRole);
        msgBox.addButton(QString("Удалить"), QMessageBox::YesRole);
        

        int ret = msgBox.exec();
        if(ret == QMessageBox::YesRole){
            int id = items.at(0)->data(0).toInt();
            model.deleteRow(id);
            clearTable();
            addRowsInTable(model.getRows());
        }

    } else {
        window.errorLabel->setText("Строка не выбрана!");
    }
    
}

void View::addRow() {
    window.errorLabel->setText("");
    

    clearTable();
    addRowsInTable(model.getRows());
    //comboBox->currentText()
}

void View::updateRow() {
    window.errorLabel->setText("");
    
    
    //comboBox->currentText()
    clearTable();
    addRowsInTable(model.getRows());
}

void View::filterApply() {
    window.errorLabel->setText("");
    QString str = window.lineEdit->text().trimmed();
    bool ok;
    int num = str.toInt(&ok);
    if(ok) {
        if(num >= 0 && num <= 1000000) {
            clearTable();
            addRowsInTable(model.getFilterRows(str));
        } else {
            window.errorLabel->setText("Фильтр должен быть числом от 0 до 1000000!");
        }
        
    } else {
        window.errorLabel->setText("Фильтр должен быть числом от 0 до 1000000!");
    }


    
}

void View::filterCancel() {
    window.errorLabel->setText("");
    
    clearTable();
    addRowsInTable(model.getRows());
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

    connect(
        window.updateButton, 
        SIGNAL(clicked()), 
        this, 
        SLOT(updateRow())
    );
    
    connect(
        window.filterApplyButton, 
        SIGNAL(clicked()), 
        this, 
        SLOT(filterApply())
    );

    connect(
        window.filterCancelButton, 
        SIGNAL(clicked()), 
        this, 
        SLOT(filterCancel())
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

void View::addItemsInCombobox(QStringList items) {
    for(QString item: items) {
        window.comboBox->addItem(item);
    }
    
}

void View::addRowsInTable(std::vector<QStringList> rows) {
    for(QStringList row: rows) {
        addItemsInCombobox(row);
    }
}

bool View::checkForm() {

}
