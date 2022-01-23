package model

import (
	"database/sql"
	"log"
	"strings"
	"unicode"
	"unicode/utf8"

	"github.com/danilbushkov/university/3_semester/coursework/web/database"
)

type User struct {
	Id       int    `json:"id"`
	Login    string `json:"login"`
	Password string `json:"password"`
}

func (u *User) Auth() int {
	code := u.checkLoginAndPassword()
	if code == 0 {
		if !u.checkUser() {
			code = 7
		}
	}

	return code
}

func (u *User) Registration() int {
	code := u.checkLoginAndPassword()
	if code == 0 {
		if u.checkExistsLogin() {
			return 8
		}
		u.AddDB()
	}
	return code
}

func (u *User) checkLoginAndPassword() int {
	if u.Login == "" {
		return 1
	}
	if utf8.RuneCountInString(u.Login) < 4 {
		return 2
	}
	if u.Password == "" {
		return 3
	}
	if utf8.RuneCountInString(u.Password) < 6 {
		return 4
	}

	if (!isASCII(u.Login)) || (strings.Contains(u.Login, " ")) {
		return 5
	}
	if (!isASCII(u.Password)) || (strings.Contains(u.Password, " ")) {
		return 6
	}
	return 0
}

func (u *User) checkUser() bool {
	if id := u.checkDB(); id > 0 {
		u.Id = id
		return true
	}
	return false
}

func isASCII(s string) bool {
	for i := 0; i < len(s); i++ {
		if s[i] > unicode.MaxASCII {
			return false
		}
	}
	return true
}

func (u *User) AddDB() {
	if u.Login == "" || u.Password == "" {
		return
	}
	_, err := database.DB.Exec("INSERT INTO users (login,password) VALUES ($1,$2)", u.Login, u.Password)
	if err != nil {
		log.Fatal(err)
	}
}

func (u *User) checkExistsLogin() bool {
	var exists bool
	row := database.DB.QueryRow("SELECT EXISTS(SELECT 1 FROM users WHERE login=$1)",
		u.Login)
	err := row.Scan(&exists)

	if err != nil {
		log.Fatal(err)
	}
	return exists
}

func (u *User) checkDB() int {
	var id int
	row := database.DB.QueryRow("SELECT id FROM users WHERE login=$1 AND password=$2",
		u.Login, u.Password)
	err := row.Scan(&id)
	if err != nil {
		if err == sql.ErrNoRows {
			return 0
		} else {
			log.Fatal(err)
		}
	}
	//log.Println(id)
	return id
}
