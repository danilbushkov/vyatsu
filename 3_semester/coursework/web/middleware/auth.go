package middleware

import (
	"strings"

	"github.com/danilbushkov/university/3_semester/coursework/web/model"
	"github.com/gin-gonic/gin"
)

type StatusAuth struct {
	Token string
	Auth  bool
}

func MiddlewareToken(c *gin.Context) {
	authHeader := c.GetHeader("Authorization")
	if authHeader == "" {
		c.Set("StatusAuth", StatusAuth{
			Auth: false,
		})
		return
	}

	headerParts := strings.Split(authHeader, " ")

	if len(headerParts) != 2 {
		c.Set("StatusAuth", StatusAuth{
			Auth: false,
		})
		return
	}

	if headerParts[0] != "Bearer" {
		c.Set("StatusAuth", StatusAuth{
			Auth: false,
		})
		return
	}
	token := headerParts[1]
	if model.CheckToken(token) {
		c.Set("StatusAuth", StatusAuth{
			Token: token,
			Auth:  true,
		})
		return
	}
	c.Set("StatusAuth", StatusAuth{
		Auth: false,
	})
}
