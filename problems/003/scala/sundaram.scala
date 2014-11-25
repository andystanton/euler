val target: Long = 600851475143L

// http://en.wikipedia.org/wiki/Sieve_of_Sundaram
def sundaramSieve(max: Int): Seq[Int] = {
  val range = (2 to max)
  range.diff(for {
    i <- range
    j <- range
    candidate = i + j + (2 * i * j) if i <= j && candidate <= max
  } yield candidate).map(_ * 2 + 1)
}

val primes = sundaramSieve(10000)
val primeFactors = primes.filter(target % _ == 0)
val largestPrime = primeFactors.reverse.head

println(largestPrime)
