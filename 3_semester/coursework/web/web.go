package main

import (
	"github.com/danilbushkov/university/3_semester/coursework/web/config"
	"github.com/danilbushkov/university/3_semester/coursework/web/database"
	"github.com/danilbushkov/university/3_semester/coursework/web/routes"
	"github.com/gin-gonic/gin"
)

func main() {
	config.Config = config.InitConfig()
	database.DB = database.InitDB()
	defer database.DB.Close()

	r := gin.Default()
	routes.GetRoutes(r)
	r.Run()
}
