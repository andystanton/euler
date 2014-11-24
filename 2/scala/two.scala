def rfibs(max: Int): Seq[Int] = {
  rfibs(Seq(2, 1), max)
}

@annotation.tailrec def rfibs(fibs: Seq[Int], max: Int): Seq[Int] = {
  fibs.head + fibs.tail.head match {
    case next: Int if next <= max => rfibs(Seq(next) ++ fibs, max)
    case _ => fibs
  }
}

println(rfibs(4000000).filter(_ % 2 == 0).sum)
