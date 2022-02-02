package routes

import (
	"log"
	"net/http"
	"strconv"

	"github.com/danilbushkov/university/3_semester/coursework/web/middleware"
	"github.com/danilbushkov/university/3_semester/coursework/web/model"
	"github.com/gin-gonic/gin"
)

func TaskRoutes(r *gin.Engine) {
	r.POST("/task/add", CheckAuthWrapper(AddTask))
	r.POST("/task/update", CheckAuthWrapper(UpdateTask))
	r.GET("/task/delete", CheckAuthWrapper(DeleteTask))
	r.GET("/tasks/get/all", CheckAuthWrapper(GetAllTask))
	r.GET("/check", CheckAuthWrapper(Check))
}

func GetAllTask(c *gin.Context) {
	v, exists := c.Get("StatusAuth")
	if !exists {
		log.Fatal("The key does not exist")
	}
	result, status := model.GetAllTasks(v.(middleware.StatusAuth).UserId)
	if status != 0 {
		c.JSON(http.StatusBadRequest, gin.H{"status": status, "tasks": []model.Task{}})
	} else {
		c.JSON(200, gin.H{"status": status, "tasks": result})
	}

}

func DeleteTask(c *gin.Context) {
	id, err := strconv.Atoi(c.Query("id"))

	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"status": 15})
		return
	}
	v, exists := c.Get("StatusAuth")
	if !exists {
		log.Fatal("The key does not exist")
	}
	result := model.DeleteDB(v.(middleware.StatusAuth).UserId, id)
	if result == 0 {
		c.JSON(200, gin.H{"status": result})
	} else {
		c.JSON(http.StatusBadRequest, gin.H{"status": result})
	}
}

func AddTask(c *gin.Context) {
	var task model.TaskJSON
	if err := c.ShouldBindJSON(&task); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"status": 10, "id": 0})
		return
	}
	v, exists := c.Get("StatusAuth")
	if !exists {
		log.Fatal("The key does not exist")
	}
	var id int
	var date string
	result := task.AddDB(v.(middleware.StatusAuth).UserId, &id, &date)
	if result == 0 {
		c.JSON(200, gin.H{"status": result, "id": id, "date_create": date})
	} else {
		c.JSON(http.StatusBadRequest, gin.H{"status": result, "id": 0, "date_create": ""})
	}
}

func UpdateTask(c *gin.Context) {
	var task model.TaskJSON
	if err := c.ShouldBindJSON(&task); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"status": 14})
		return
	}
	v, exists := c.Get("StatusAuth")
	if !exists {
		log.Fatal("The key does not exist")
	}
	result := task.UpdateTask(v.(middleware.StatusAuth).UserId)
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

func Check(c *gin.Context) {

	c.JSON(200, gin.H{"status": 0})

}
