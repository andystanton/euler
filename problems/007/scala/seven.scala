def primeCandidates = new Iterator[Int] {
  var i = 1
  def hasNext = true
  def next(): Int = { i += 2; i }
}

println(primeCandidates take 20 toList)
