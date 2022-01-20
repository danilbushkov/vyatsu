package model

import (
	"time"

	"github.com/dgrijalva/jwt-go"
)

type claims struct {
	jwt.StandardClaims
	Id int `json:"id"`
}

const Key = "Test"

func GetToken(id int) string {

	if id > 0 {
		token := jwt.NewWithClaims(jwt.SigningMethodHS256, &claims{
			StandardClaims: jwt.StandardClaims{
				ExpiresAt: time.Now().Unix() + 2629743,
				IssuedAt:  time.Now().Unix(),
			},
			Id: id,
		})
		t, err := token.SignedString([]byte(Key))
		if err == nil {
			return t
		}
	}
	return ""
}
