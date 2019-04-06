package scala.problem_1

import scala.collection.immutable.Stream
import scala.annotation.tailrec

/**
 * Multiples of 3 and 5
 * Problem 1
 *
 * If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
 *
 * Find the sum of all the multiples of 3 or 5 below 1000.
 *
 */
object Main {
  def main(args: Array[String]): Unit = {
    def stepSequence(head: Int, stepping: (Int) => Boolean): Stream[Int] =
      head #:: stepSequence(head + 1, stepping).filter(stepping)
    
    val limit = 1000;
    val stepping = (x: Int) => {(x % 3 == 0) || (x % 5 == 0)}

    // 
    val l = stepSequence(0, stepping).takeWhile { _ < limit }

    //    l.foreach(println)
    println("result: %d".format(l.sum))

  }
}