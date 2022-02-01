package routes

import (
	"github.com/gin-gonic/gin"
)

func GetRoutes(r *gin.Engine) {

	UserRoutes(r)
	TaskRoutes(r)

}
