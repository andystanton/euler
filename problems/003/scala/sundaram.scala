// http://en.wikipedia.org/wiki/Sieve_of_Sundaram
def sundaramSieve(limit: Int): collection.SortedSet[Int] = {
  val range = (2 to limit)
  val primeList = range.diff(for {
    i <- range
    j <- range
    candidate = i + j + (2 * i * j) if i <= j && candidate <= limit
  } yield candidate).map(_ * 2 + 1)
  collection.SortedSet(primeList: _*)
}

def largestPrimeFactor(target: Long, limit: Int) = sundaramSieve(limit).filter(target % _ == 0).last

val target: Long = 600851475143L
val limit: Int = 10000

println(largestPrimeFactor(target, limit))
