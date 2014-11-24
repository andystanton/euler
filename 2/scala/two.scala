import annotation.tailrec

def rfibs(max: Int): Seq[Int] = {
  rfibs(Seq(2, 1), max)
}

@tailrec def rfibs(fibSeq: Seq[Int], max: Int): Seq[Int] = {
  fibSeq.head + fibSeq.tail.head match {
    case valid: Int if valid < max => rfibs(Seq(valid) ++ fibSeq, max)
    case _ => fibSeq
  }
}

println(rfibs(4000000).filter(_ % 2 == 0).sum)
