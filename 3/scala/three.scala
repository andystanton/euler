val target: Long = 600851475143L

def sundaramSieve(max: Long): Seq[Long] = {
  val range = (2L to max)
  range.diff(for {
    i <- range
    j <- range
    candidate = i + j + (2 * i * j) if i <= j && (candidate <= max)
  } yield candidate).map(_ * 2 + 1)
}

val primes = sundaramSieve(10000L)
val primeFactors = primes.filter(target % _ == 0)
val largestPrime = primeFactors.reverse.head

println(largestPrime)
