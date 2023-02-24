#ifndef VIEW_H
#define VIEW_H

#include <ui.h>
#include <string>

class View: public QMainWindow {
    Q_OBJECT

private:
    Ui::MainWindow window;
    std::string state;
    int id = 0;
    
public:
    

    View(): QMainWindow() {
        state = "table";
        window.setupUi(this);
        window.retranslateUi(this);
        window.addArea->setVisible(false);

        QStringList headers = { "id", "Название", "Цена", "Количество тренировок", "Зал" };
        window.tableWidget->setColumnCount(5); 
        window.tableWidget->setShowGrid(true); 
        window.tableWidget->setSelectionMode(QAbstractItemView::SingleSelection);
        window.tableWidget->setSelectionBehavior(QAbstractItemView::SelectRows);
        window.tableWidget->setHorizontalHeaderLabels(headers);
        window.tableWidget->horizontalHeader()->setStretchLastSection(true);
        window.tableWidget->hideColumn(0);
        
        addItemsInCombobox({"Test", "Test2"});

        bindHandlers();

        
    };

    void bindHandlers();
    void addRowInTable(QStringList row);
    void clearTable();

    void addItemsInCombobox(QStringList row);

private slots:
    void viewTable();
    void viewAddForm();
    void viewUpdateForm();
    void deleteRow();
    void addRow();
    void updateRow();
    void filterApply();
    void filterCancel();




};


#endif