#ifndef VIEW_H
#define VIEW_H

#include <ui.h>
#include <string>
#include <QtWidgets/QMessageBox>
#include <model.h>
#include <unordered_map>

class View: public QMainWindow {
    Q_OBJECT

private:
    Ui::MainWindow window;
    std::string state;
    int id = 0;
    Model model;
    QMap<QString, QString> keys;
public:
    

    View(): QMainWindow() {
        state = "table";
        window.setupUi(this);
        window.retranslateUi(this);
        window.addArea->setVisible(false);
        model = Model();

        QStringList headers = { "id", "Название", "Цена", "Количество тренировок", "Зал" };
        window.tableWidget->setColumnCount(5); 
        window.tableWidget->setShowGrid(true); 
        window.tableWidget->setSelectionMode(QAbstractItemView::SingleSelection);
        window.tableWidget->setSelectionBehavior(QAbstractItemView::SelectRows);
        window.tableWidget->setHorizontalHeaderLabels(headers);
        window.tableWidget->horizontalHeader()->setStretchLastSection(true);
        window.tableWidget->hideColumn(0);
        
        window.errorLabel->setStyleSheet("QLabel { color : red; }");

        
        
        std::vector<QStringList> vec = model.getKeys();
        for(int i = 0; i < vec.size(); i++) {
            keys[vec[1][i]] = vec[0][i];
        }

        addItemsInCombobox(vec[1]);
        addRowsInTable(model.getRows());
        bindHandlers();

        
    };

    virtual ~View(){};

    void bindHandlers();
    void addRowInTable(QStringList row);
    void clearTable();
    void addRowsInTable(std::vector<QStringList> rows);

    void addItemsInCombobox(QStringList row);
    QStringList getFormItems();

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