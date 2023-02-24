#ifndef DATABASE_H
#define DATABASE_H


#include <pqxx/pqxx>
#include <string>


class DataBase {
private:
    pqxx::connection *conn;

public:
    DataBase() {
        conn = new pqxx::connection("dbname=testdb hostaddr=127.0.0.1 user=testuser password=testpassword port=5432" );
        //db = QSqlDatabase::addDatabase("QPSQL");
    };


    void exec(std::string sql) {
        pqxx::work w(*conn);
        w.exec(sql);
        w.commit();
    }

    ~DataBase() {
        
        delete conn;
    };
};


#endif