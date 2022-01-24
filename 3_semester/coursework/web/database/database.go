package database

import (
	"database/sql"
	"log"

	"github.com/danilbushkov/university/3_semester/coursework/web/config"
	"github.com/gomodule/redigo/redis"
	_ "github.com/lib/pq"
)

var DB *sql.DB
var Redis *redis.Pool

func InitDB(c *config.DBconfig) *sql.DB {
	connStr := "user=" + c.User +
		" password=" + c.Password +
		" dbname=" + c.DBname +
		" host=" + c.Host +
		" port=" + c.Port +
		" sslmode=disable"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}
	return db
}

func NewPool(c *config.RedisConfig) *redis.Pool {
	return &redis.Pool{
		MaxIdle:   80,
		MaxActive: 12000,
		Dial: func() (redis.Conn, error) {
			c, err := redis.DialURL("redis://" + c.Password +
				"@" + c.Host + ":" + c.Port)
			if err != nil {
				log.Fatal(err)
			}
			return c, err
		},
	}
}
