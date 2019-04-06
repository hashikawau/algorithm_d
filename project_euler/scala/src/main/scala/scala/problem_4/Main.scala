package scala.problem_4

/**
 * Largest palindrome product
 * Problem 4
 *
 * A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
 *
 * Find the largest palindrome made from the product of two 3-digit numbers.
 *
 */
object Main {
  def main(args: Array[String]): Unit = {
    def isPalindrome(number: Int): Boolean = {
      val str = number.toString()
      str == str.reverse
    }
    def palindromes(limit: Int): Stream[Int] = {
      Stream.from(limit, -1).filter(isPalindrome)
    }
    def getTwoPrimes(x: Int): List[Tuple3[Int, Int, Int]] = {
      val min = 100;
      val max = 999;
      Stream
        .from(100)
        .takeWhile(_ <= max)
        .filter((i) => { (x % i == 0) && (x / i >= min) && (x / i <= max) })
        .map((i) => { (x, i, x / i) })
        .toList
    }

    val l = palindromes(999 * 999).map(getTwoPrimes).filter(_.size > 0).head
    l.foreach(println)
  }

}