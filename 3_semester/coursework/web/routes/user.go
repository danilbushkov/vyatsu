package routes

import (
	"log"
	"net/http"

	"github.com/danilbushkov/university/3_semester/coursework/web/middleware"
	"github.com/danilbushkov/university/3_semester/coursework/web/model"
	"github.com/gin-gonic/gin"
)

func UserRoutes(r *gin.Engine) {
	r.POST("/auth", func(c *gin.Context) {

		user := model.User{
			Login:    c.DefaultPostForm("login", ""),
			Password: c.DefaultPostForm("password", ""),
		}

		result := user.Auth()
		token := model.GetToken(user.Id)
		if result == 0 {
			model.SaveToken(token)
		}

		c.JSON(200, gin.H{
			"status": result,
			"token":  token,
		})
	})

	r.POST("/registration", func(c *gin.Context) {

		user := model.User{
			Login:    c.DefaultPostForm("login", ""),
			Password: c.DefaultPostForm("password", ""),
		}

		result := user.Registration()

		c.JSON(200, gin.H{
			"status": result,
		})
	})

	r.GET("/logout", func(c *gin.Context) {
		var result int
		value, exists := c.Get("StatusAuth")
		if !exists {
			log.Fatal("The Token variable does not exist")
		}
		status := value.(middleware.StatusAuth)

		if status.Auth {
			model.RemoveToken(status.Token)
			result = 0
		} else {
			c.JSON(http.StatusUnauthorized, gin.H{
				"status": 9,
			})
			return
		}

		c.JSON(200, gin.H{
			"status": result,
		})
	})

	r.GET("/user/id/get", func(c *gin.Context) {
		var result int = 9
		var code int = 401
		var id int = 0

		v, exists := c.Get("StatusAuth")
		if !exists {
			log.Fatal("The key does not exist")
		}

		if v.(middleware.StatusAuth).Auth {
			userId, err := model.GetUserId(v.(middleware.StatusAuth).Token)
			if err == nil {
				id = userId
				result = 0
				code = 200
			}

		}

		c.JSON(code, gin.H{
			"status": result,
			"id":     id,
		})
	})
}
