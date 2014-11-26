def highestCommonMultiplesIn(range: Seq[Int]): Seq[Int] = {
  val factors = for {
    i <- range
    j <- range
    candidate = i % j if candidate == 0 && i > j
  } yield j
  range.diff(factors)
}

def getNaturalNumbers(startValue: Int) = new Iterator[Int] {
  var i = startValue -1
  def hasNext = true
  def next(): Int = { i+=1; i }
}

def lowestCommonMultipleForAllIn(sourceRange: Seq[Int], next: Int, nnIt: Iterator[Int]): Int = {
  sourceRange.forall(next % _ == 0) match {
    case true => next
    case _ => lowestCommonMultipleForAllIn(sourceRange, nnIt.next, nnIt)
  }
}

def lowestCommonMultipleForAllIn(start: Int, end: Int): Int = {
  lowestCommonMultipleForAllIn(highestCommonMultiplesIn(start to end), end, getNaturalNumbers(start))
}

println(lowestCommonMultipleForAllIn(1, 20))
