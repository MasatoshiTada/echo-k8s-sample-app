package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/labstack/echo/v4"
)

// "App名(Pod名)"という文字列を返すAPI
func main() {
	appname := os.Getenv("APPNAME")
	if appname == "" {
		appname = "Cannot get App's name"
	}
	hostname := os.Getenv("HOSTNAME")
	if hostname == "" {
		hostname = "Cannot get Pod's name"
	}

	e := echo.New()
	e.GET("/**", func(c echo.Context) error {
		return c.String(http.StatusOK, fmt.Sprintf("%s(%s)", appname, hostname))
	})
	e.Logger.Fatal(e.Start(":80"))
}
