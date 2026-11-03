package main

import (
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	r.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"status": "ok"})
	})

	r.GET("/api/hello", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"message": "Hello from MetroIsJustABus backend"})
	})

	// Serve the built React app (copied into /app/static in the image)
	r.Static("/assets", "./static/assets")
	r.NoRoute(func(c *gin.Context) {
		c.File("./static/index.html")
	})

	port := os.Getenv("PORT")
	if port == "" {
		port = "5000"
	}
	r.Run(":" + port)
}