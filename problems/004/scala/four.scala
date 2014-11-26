def isPalindrome(num: Int) = num.toString == num.toString.reverse

def getAllPalindromesInRange(targetRange: Seq[Int]) = {
  for {
    x <- targetRange
    y <- targetRange
    product = x * y if isPalindrome(product)
  } yield product
}

println(getAllPalindromesInRange(100 to 999).sortWith(_ > _).head)
