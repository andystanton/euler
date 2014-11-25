import scala.collection.mutable.ArraySeq
import scala.math.sqrt

val target: Long = 600851475143L

// http://en.wikipedia.org/wiki/Sieve_of_Atkin
def atkinSieve(max: Int): Seq[Int] = {
  val sqrtMax = sqrt(max)
  for {
    x <- (1 to sqrtMax.toInt)
    y <- (1 to sqrtMax.toInt)
    n = (4 * x^2 + y^2)
    m = (3 * x^2 + y^2)
    ntrue = (n % 12 == 1 || n % 12 == 5)
    if ntrue || (m < max && m % 12 == 11)
  } yield {
    if (ntrue) n else m
  }
}

val primes = atkinSieve(10000000)
val primeFactors = primes.filter(target % _ == 0)
val largestPrime = primeFactors.reverse.head

println(largestPrime)
