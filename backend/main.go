package main

import (
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
)

func newRouter() *gin.Engine {
	router := gin.Default()

	router.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"status": "ok"})
	})

	router.GET("/api/hello", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"message": "Hello from MetroIsJustABus backend"})
	})

	// TST-05: preserve the production frontend and fallback routes covered by smoke tests.
	router.Static("/assets", "./static/assets")
	router.NoRoute(func(c *gin.Context) {
		c.File("./static/index.html")
	})

	return router
}

func main() {
	router := newRouter()

	port := os.Getenv("PORT")
	if port == "" {
		port = "5000"
	}
	router.Run(":" + port)
}
