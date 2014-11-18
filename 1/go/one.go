package main
import "fmt"
func main() {
    sum := 0
    for j := 0; j < 1000; j++ {
        if j % 3 == 0 || j % 5 == 0 {
            sum += j
        }
    }
    fmt.Println(sum)
}
