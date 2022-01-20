package main

import (
	"github.com/danilbushkov/university/3_semester/coursework/web/routes"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	routes.GetRoutes(r)
	r.Run()
}
