package model

import (
	"log"
	"time"

	"github.com/danilbushkov/university/3_semester/coursework/web/database"
	"github.com/dgrijalva/jwt-go"
)

type claims struct {
	jwt.StandardClaims
	Id int `json:"id"`
}

const Key = "Test"
const ActivityInterval = 6000

func GetToken(id int) string {

	if id > 0 {
		token := jwt.NewWithClaims(jwt.SigningMethodHS256, &claims{
			StandardClaims: jwt.StandardClaims{
				ExpiresAt: time.Now().Unix() + ActivityInterval,
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

func SaveToken(token string) {
	client := database.Redis.Get()
	defer client.Close()

	_, err := client.Do("SET", token, "", "EX", ActivityInterval)
	if err != nil {
		log.Fatal(err)
	}
}

func CheckToken(token string) bool {
	client := database.Redis.Get()
	defer client.Close()

	value, err := client.Do("EXISTS", token)
	if err != nil {
		log.Fatal(err)
	}

	return value.(int64) == 1

}

func RemoveToken(token string) {
	client := database.Redis.Get()
	defer client.Close()

	_, err := client.Do("DEL", token)
	if err != nil {
		log.Fatal(err)
	}
}

func GetUserId(t string) (int, error) {
	token, err := jwt.ParseWithClaims(t, &claims{}, func(token *jwt.Token) (interface{}, error) {
		return []byte(Key), nil
	})

	if claims, ok := token.Claims.(*claims); ok && token.Valid {
		return claims.Id, nil
	} else {
		return 0, err
	}

}
