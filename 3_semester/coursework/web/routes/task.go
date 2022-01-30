package routes

import (
	"log"
	"net/http"

	"github.com/danilbushkov/university/3_semester/coursework/web/middleware"
	"github.com/danilbushkov/university/3_semester/coursework/web/model"
	"github.com/gin-gonic/gin"
)

func TaskRoutes(r *gin.Engine) {
	r.POST("/task/add", CheckAuthWrapper(AddTask))

}

func AddTask(c *gin.Context) {
	var task model.TaskJSON
	if err := c.ShouldBindJSON(&task); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"status": 10})
		return
	}
	v, exists := c.Get("StatusAuth")
	if !exists {
		log.Fatal("The key does not exist")
	}

	result := task.AddDB(v.(middleware.StatusAuth).UserId)
	if result == 0 {
		c.JSON(200, gin.H{"status": result})
	} else {
		c.JSON(http.StatusBadRequest, gin.H{"status": result})
	}
}

func CheckAuthWrapper(f func(c *gin.Context)) func(c *gin.Context) {
	return func(c *gin.Context) {
		v, exists := c.Get("StatusAuth")
		if !exists {
			log.Fatal("The key does not exist")
		}
		if !v.(middleware.StatusAuth).Auth {
			c.JSON(401, gin.H{
				"status": 9,
			})
			return
		}

		f(c)
	}
}
