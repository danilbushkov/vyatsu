package model

import (
	"strings"
	"unicode"
	"unicode/utf8"
)

type User struct {
	Id       int    `json:"id"`
	Login    string `json:"login"`
	Password string `json:"password"`
}

func (u *User) Auth() int {
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
	if u.checkUser() {
		return 0
	}
	return 7
}

func (u *User) checkUser() bool {
	if (u.Login == "test") && (u.Password == "123456") {
		u.Id = 1
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
