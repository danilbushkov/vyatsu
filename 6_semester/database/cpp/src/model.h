#ifndef MODEL_H
#define MODEL_H

#include <vector>
#include <database.h>
#include <QStringList>

class Model {
private: 
    std::vector<QStringList> rows;
    int count = 0;

    DataBase *db;

public:
    

    Model() {
        db = new DataBase();
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
        db->exec("DELETE FROM subscription WHERE id="+std::to_string(id));
    }

    void updateRow(QStringList row) {
        std::string s = " UPDATE subscription \
            SET \
                name ="  + row[1].toStdString() +","+  
                "cost =" + row[2].toStdString() +","+ 
                "num_trainings =" + row[3].toStdString() +","+
                "gym_id ="+ row[4].toStdString() + 
            "WHERE id =" + row[0].toStdString();
        db->exec(s);
    }

    void addRow(QStringList row) {

        std::string s = "INSERT INTO subscription ( \ 
            name, cost, num_trainings, gym_id)  \
            VALUES (" + 
            row[0].toStdString()+","+ 
            row[1].toStdString()+","+
            row[2].toStdString()+","+
            row[3].toStdString() + ")";

        db->exec(s);

        // row.push_front(QString(count));
        // count++;
        // rows.push_back(row);
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
            "1",
            "Name"+QString(count),
            "cost"+QString(count),
            "trainings"+QString(count),
            "gym2"
        };
        count++;
    }


    ~Model() {
        delete db;
    }

};



#endif