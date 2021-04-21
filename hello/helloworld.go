package main

import (
	"fmt"
)

// build for Windows OS
// GOOS=windows GOARCH=amd64 go build -ldflags '-s -w' helloworld.go
func main() {
	fmt.Println("hello world from wine")
}
