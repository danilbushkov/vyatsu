package routes

import (
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

}
