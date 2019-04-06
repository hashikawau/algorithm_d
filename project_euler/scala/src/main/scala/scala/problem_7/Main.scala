package scala.problem_7

import scala.annotation.tailrec
import scala.collection.immutable.Stream.consWrapper

/**
 * 10001st prime
 * Problem 7
 *
 * By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
 *
 * What is the 10 001st prime number?
 *
 */
object Main {
  def main(args: Array[String]): Unit = {

    val l = primeseq()
    l.take(10001).foreach(println)
  }

  def primeseq(): Stream[Int] = {
    def helper(seq: Stream[Int]): Stream[Int] = {
      seq.head #:: helper(seq.tail.filter(_ % seq.head != 0))
    }
    helper(Stream.from(2))
  }

}