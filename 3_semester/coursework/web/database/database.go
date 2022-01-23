package database

import (
	"database/sql"
	"log"

	"github.com/danilbushkov/university/3_semester/coursework/web/config"
	_ "github.com/lib/pq"
)

var DB *sql.DB

func InitDB() *sql.DB {
	connStr := "user=" + config.Config.DB.User +
		" password=" + config.Config.DB.Password +
		" dbname=" + config.Config.DB.DBname +
		" host=" + config.Config.DB.Host +
		" port=" + config.Config.DB.Port +
		" sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}
	return db
}
