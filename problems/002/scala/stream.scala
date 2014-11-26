val fibs: Stream[Int] = 0 #:: fibs.scanLeft(1)(_ + _)

println(fibs.takeWhile(_ < 4000000).filter(_ % 2 == 0).sum)
