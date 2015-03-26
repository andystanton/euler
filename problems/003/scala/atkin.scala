// http://en.wikipedia.org/wiki/Sieve_of_Atkin
def atkinSieve(max: Int): collection.SortedSet[Int] = {
  val sqrtMax = math.sqrt(max)
  val primeList = for {
    x <- (2 to sqrtMax.toInt)
    y <- (2 to x)
    n = (4 * x^2 + y^2)
    m = (3 * x^2 + y^2)
    ntrue = (n % 12 == 1 || n % 12 == 5)
    if ntrue || (m < max && m % 12 == 11)
  } yield {
    if (ntrue) n else m
  }
  collection.SortedSet(primeList: _*)
}

def largestPrimeFactor(target: Long, limit: Int) = atkinSieve(limit).filter(target % _ == 0).last

val target: Long = 600851475143L
val limit: Int = 100000000

println(largestPrimeFactor(target, limit))
