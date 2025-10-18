package test

import "fmt"

// TestFunction has intentional golangci-lint issues
func TestFunction() {
	// Unused variable
	x := 5

	// Inefficient string concatenation in loop
	var result string
	for i := 0; i < 10; i++ {
		result = result + fmt.Sprintf("%d", i)
	}

	fmt.Println(result)
}
