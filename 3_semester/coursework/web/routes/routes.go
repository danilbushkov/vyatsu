package routes

import (
	"log"
	"net/http"

	"github.com/danilbushkov/university/3_semester/coursework/web/middleware"
	"github.com/danilbushkov/university/3_semester/coursework/web/model"
	"github.com/gin-gonic/gin"
)

func GetRoutes(r *gin.Engine) {

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
				"status": 10,
			})
			return
		}

		c.JSON(200, gin.H{
			"status": result,
		})
	})

}
