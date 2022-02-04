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
	r.GET("/task/dates", CheckAuthWrapper(GetDates))
	r.GET("/task/history/get", CheckAuthWrapper(GetHistory))
	r.GET("/progress", CheckAuthWrapper(GetProgress))
}

func GetProgress(c *gin.Context) {
	v, exists := c.Get("StatusAuth")
	if !exists {
		log.Fatal("The key does not exist")
	}
	result, status := model.GetProgress(v.(middleware.StatusAuth).UserId)
	if status != 0 {
		c.JSON(http.StatusBadRequest, gin.H{"status": status})
	} else {
		c.JSON(200, gin.H{"status": status, "count": result.Count, "level": result.Level})
	}
}

func GetHistory(c *gin.Context) {
	id, err := strconv.Atoi(c.Query("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"status": 23})
		return
	}
	date := c.Query("date")
	if date == "" {
		c.JSON(http.StatusBadRequest, gin.H{"status": 23})
		return
	}
	v, exists := c.Get("StatusAuth")
	if !exists {
		log.Fatal("The key does not exist")
	}
	result, status := model.GetArchiveTask(v.(middleware.StatusAuth).UserId, id, date)
	if status != 0 {
		c.JSON(http.StatusBadRequest, gin.H{"status": status})
	} else {
		c.JSON(200, gin.H{"status": status, "task": *result})
	}

}

func GetDates(c *gin.Context) {
	id, err := strconv.Atoi(c.Query("id"))

	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"status": 22})
		return
	}
	v, exists := c.Get("StatusAuth")
	if !exists {
		log.Fatal("The key does not exist")
	}
	result, status := model.GetDatesUpdate(v.(middleware.StatusAuth).UserId, id)
	if status != 0 {
		c.JSON(http.StatusBadRequest, gin.H{"status": status})
	} else {
		c.JSON(200, gin.H{"status": status, "dates": result})
	}
}

func GetAllTask(c *gin.Context) {
	v, exists := c.Get("StatusAuth")
	if !exists {
		log.Fatal("The key does not exist")
	}
	result, status := model.GetAllTasks(v.(middleware.StatusAuth).UserId)
	if status != 0 {
		c.JSON(http.StatusBadRequest, gin.H{"status": status})
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
		c.JSON(http.StatusBadRequest, gin.H{"status": 10})
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
		c.JSON(http.StatusBadRequest, gin.H{"status": result})
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
	var date string
	result := task.UpdateTask(v.(middleware.StatusAuth).UserId, &date)
	if result == 0 {
		c.JSON(200, gin.H{"status": result, "date_update": date})
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
