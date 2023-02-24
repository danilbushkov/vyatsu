#ifndef MODEL_H
#define MODEL_H

#include <vector>
#include <database.h>
#include <QStringList>

class Model {
private: 
    
    int count = 0;

    DataBase *db;

public:
    

    Model() {
        db = new DataBase();
        
        // rows.push_back(getRow());
        // rows.push_back(getRow());
        // rows.push_back(getRow());
        // rows.push_back(getRow());
        // rows.push_back(getRow());
        // rows.push_back(getRow());
    }

    std::vector<QStringList> getRows() {
        std::vector<std::vector<std::string>> qrows = db->get(
            "SELECT s.id, s.name, s.cost, s.num_trainings, g.name FROM \
                subscription s \
            INNER JOIN \
                gym g \
            ON \
                s.gym_id = g.id"
        );
        std::vector<QStringList> rows;
        for(auto qrow: qrows) {
            int size = rows.size();
            rows.push_back({});
            for(auto item: qrow) {
                rows[size].push_back(QString::fromStdString(item));
            }
        }

        return rows;
    }

    void deleteRow(int id) {
        db->exec("DELETE FROM subscription WHERE id="+std::to_string(id));
    }

    void updateRow(QStringList row) {
        std::string s = " UPDATE subscription \
            SET \
                name = '"  + row[1].toStdString() +"' ,"+  
                "cost = " + row[2].toStdString() +","+ 
                "num_trainings = " + row[3].toStdString() +","+
                "gym_id = "+ row[4].toStdString() + 
            " WHERE id = " + row[0].toStdString();
        db->exec(s);
    }

    void addRow(QStringList row) {

        std::string s = "INSERT INTO subscription ( \ 
            name, cost, num_trainings, gym_id)  \
            VALUES ('" + 
            row[0].toStdString()+"',"+ 
            row[1].toStdString()+","+
            row[2].toStdString()+","+
            row[3].toStdString() + ")";

        db->exec(s);

        // row.push_front(QString(count));
        // count++;
        // rows.push_back(row);
    }

    std::vector<QStringList> getKeys() {
        std::vector<std::vector<std::string>> rows = db->get(
            "SELECT id, name FROM gym"
        );

        std::vector<QStringList> keys(2);
        for(auto row: rows) {
            for(int i = 0; i < 2; i++) {
                QString s = QString::fromStdString(row[i]);
                keys[i].push_back(s);
            }
        }

        // keys.push_back({"1", "2", "3"});
        // keys.push_back({"gym1", "gym2", "gym3"});
        return keys;
    }

    std::vector<QStringList> getFilterRows(QString filter) {
        std::vector<std::vector<std::string>> qrows = db->get(
            "SELECT s.id, s.name, s.cost, s.num_trainings, g.name FROM \
                subscription s \
            INNER JOIN \
                gym g \
            ON \
                s.gym_id = g.id \
            WHERE s.cost >= " + filter.toStdString()
        );
        std::vector<QStringList> rows;
        for(auto qrow: qrows) {
            int size = rows.size();
            rows.push_back({});
            for(auto item: qrow) {
                rows[size].push_back(QString::fromStdString(item));
            }
        }

        return rows;
    }

    


    ~Model() {
        
        delete db;
    }

};



#endif