#ifndef DATABASE_H
#define DATABASE_H


#include <pqxx/pqxx>
#include <string>
#include <iostream>


class DataBase {
private:
    pqxx::connection *conn;

public:
    DataBase() {
        conn = new pqxx::connection("dbname=testdb hostaddr=127.0.0.1 user=testuser password=testpassword port=5432" );
        
    };


    void exec(std::string sql) {
        pqxx::work w(*conn);
        w.exec(sql);
        w.commit();
    }

    std::vector<std::vector<std::string>> get(std::string sql) {
        std::vector<std::vector<std::string>> result;

        pqxx::nontransaction n(*this->conn);
        
        pqxx::result r(n.exec(sql));
        for(pqxx::result::const_iterator items = r.begin(); items != r.end(); items++) {
            int size = result.size();
            result.push_back({});
            for(auto item: items) {
                result[size].push_back(item.c_str());
            }
            
            
        }
        

        return result;
    }



    ~DataBase() {
        conn->disconnect();
        delete conn;
    };
};


#endif