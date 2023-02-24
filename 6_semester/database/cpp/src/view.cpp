
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
        
        
        int cur = window.tableWidget->currentRow();
        if(cur != -1) {
            state = "update";
            window.label1->setText("Изменение");
            window.addArea->setVisible(true);
            window.tableArea->setVisible(false);
            window.addButton->setVisible(false);
            window.updateButton->setVisible(true);

            id = window.tableWidget->item(cur, 0)->data(0).toInt();
            QString name = window.tableWidget->item(cur, 1)->data(0).toString();
            QString cost = window.tableWidget->item(cur, 2)->data(0).toString();
            QString trainingsCount = window.tableWidget->item(cur, 3)->data(0).toString();
            QString gym = window.tableWidget->item(cur, 4)->data(0).toString();
            
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
    int cur = window.tableWidget->currentRow();
    if(cur != -1) {
        QMessageBox msgBox;
        msgBox.setWindowTitle("Удаление.");
        msgBox.setInformativeText("Вы уверены, что хотите удалить строку?");
        
        msgBox.addButton(QString("Отмена"), QMessageBox::NoRole);
        msgBox.addButton(QString("Удалить"), QMessageBox::YesRole);
        

        int ret = msgBox.exec();
        if(ret == QMessageBox::YesRole){
            int id = window.tableWidget->item(cur, 0)->data(0).toInt();
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
    
    QStringList row = getFormItems();
    if(row.size() > 0) {
        model.addRow(row);
        clearTable();
        addRowsInTable(model.getRows());
        viewTable();
    }

    
    
}

void View::updateRow() {
    window.errorLabel->setText("");
    
    QStringList row = getFormItems();
    if(row.size() > 0) {
        model.updateRow(row);
        clearTable();
        addRowsInTable(model.getRows());
        viewTable();
    }
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
        addRowInTable(row);
    }
}

QStringList View::getFormItems() {
    QString name = window.nameEdit->text().trimmed();
    QString cost = window.costEdit->text().trimmed();
    QString trainingsCount = window.trainingsInput->text().trimmed();
    QString gym = window.comboBox->currentText();
    
    keys[window.comboBox->currentText()];

    if(name.size() == 0 || name.size() > 50) {
        window.errorLabel->setText("Имя должно быть заполнено, длина от 1 до 50!");
        return {};
    }

    bool ok;
    int num = cost.toInt(&ok);
    if(!ok || num < 0 || num > 1000000) {
        window.errorLabel->setText("Цена должна быть числом от 0 до 1000000!");
        return {};
    }

    num = trainingsCount.toInt(&ok);
    if(!ok || num < 0 || num > 1000) {
        window.errorLabel->setText("Количество тренировок должно быть числом от 0 до 1000!");
        return {};
    }

    if(gym == "") {
        window.errorLabel->setText("Не выбран зал!");
        return {};
    }
    QString gymId = keys[gym];

    if(state == "update") {
        return {QString(id), name, cost, trainingsCount, gymId};
    } 
    return {name, cost, trainingsCount, gymId};
}
