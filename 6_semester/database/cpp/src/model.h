#ifndef MODEL_H
#define MODEL_H

#include <vector>

class Model {
private: 
    std::vector<QStringList> rows;
    int count = 0;
public:
    

    Model() {
        rows.push_back(getRow());
        rows.push_back(getRow());
        rows.push_back(getRow());
        rows.push_back(getRow());
        rows.push_back(getRow());
        rows.push_back(getRow());
        rows.push_back(getRow());
    }

    std::vector<QStringList> getRows() {
        return rows;
    }

    void deleteRow(int id) {
        
    }

    void updateRow(QStringList row) {

    }

    void addRow(QStringList row) {
        getRow();
    }

    std::vector<QStringList> getKeys() {
        std::vector<QStringList> keys;
        keys.push_back({"1", "2", "3"});
        keys.push_back({"gym1", "gym2", "gym3"});
        return keys;
    }

    std::vector<QStringList> getFilterRows(QString filter) {
        return rows;
    }

    QStringList getRow() {
        return {
            QString(count),
            "Name"+QString(count),
            "cost"+QString(count),
            "trainings"+QString(count),
            "gym"+QString(count),
        };
        count++;
    }

};



#endif