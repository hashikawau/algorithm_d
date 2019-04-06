package scala.problem_6

/**
 * Sum square difference
 * Problem 6
 *
 * The sum of the squares of the first ten natural numbers is,
 * 12 + 22 + ... + 102 = 385
 *
 * The square of the sum of the first ten natural numbers is,
 * (1 + 2 + ... + 10)2 = 552 = 3025
 *
 * Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.
 *
 * Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
 * 
 */
object Main {
  def main(args: Array[String]): Unit = {
    val y1 = Stream.from(1).take(100).map(i => i*i).sum
    val y2 = Stream.from(1).take(100).sum
    println("result: %d".format(y2 * y2 - y1))
  }

}