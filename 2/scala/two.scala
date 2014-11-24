import annotation.tailrec

def fibs(max: Int): Seq[Int] = {
  fibs(Seq(2, 1), max)
}

@tailrec def fibs(fibSeq: Seq[Int], max: Int): Seq[Int] = {
  fibSeq.head + fibSeq.tail.head match {
    case valid: Int if valid < max => fibs(Seq(valid) ++ fibSeq, max)
    case _ => fibSeq.reverse
  }
}

val fibsTo4Million = fibs(4000000)

println(fibsTo4Million.filter(_ % 2 == 0).sum)
