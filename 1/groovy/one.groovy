sum = (0..999).inject(0) { result, i ->
    (i % 5 == 0 || i % 3 == 0) ? result + i : result
}
println(sum)
