def squareDiff(range: Seq[Int]): Int = scala.math.pow(range.sum, 2).toInt - range.map(j=>j*j).sum

println(squareDiff(1 to 100))
