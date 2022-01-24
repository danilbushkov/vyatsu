package main

import (
	"github.com/danilbushkov/university/3_semester/coursework/web/config"
	"github.com/danilbushkov/university/3_semester/coursework/web/database"
	"github.com/danilbushkov/university/3_semester/coursework/web/middleware"
	"github.com/danilbushkov/university/3_semester/coursework/web/routes"
	"github.com/gin-gonic/gin"
)

func main() {
	config.Config = config.InitConfig()
	database.DB = database.InitDB(&config.Config.DB)
	defer database.DB.Close()

	database.Redis = database.NewPool(&config.Config.Redis)
	defer database.Redis.Close()

	r := gin.Default()

	r.Use(middleware.MiddlewareToken)

	routes.GetRoutes(r)
	r.Run()
}
