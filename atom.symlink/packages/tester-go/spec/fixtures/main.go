package main

import "fmt"

func main() {
  fmt.Println("Hello, world!")
  Covered()
}

// Covered is covered.
func Covered() {
  fmt.Println("Hello, again!")
}

// Uncovered is not covered.
func Uncovered() {
  fmt.Println("Hello, one last time!")
}
