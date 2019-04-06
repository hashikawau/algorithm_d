package scala.problem_3

import scala.annotation.tailrec

/**
 * Largest prime factor
 * Problem 3
 *
 * The prime factors of 13195 are 5, 7, 13 and 29.
 *
 * What is the largest prime factor of the number 600851475143 ?
 *
 */
object Main {
  def main(args: Array[String]): Unit = {
    def getDivisors(number: Long): Stream[Int] = {
      Stream.from(2).filter(number % _ == 0)
    }
    @tailrec
    def decomposeToPrimeFactors(number: Long, primes: List[Int]): List[Int] = {
      val div = getDivisors(number).head
      val newprimes = primes :+ div
      
//      println("number, div: %d, %d".format(number, div))

      if (div == number) newprimes
      else decomposeToPrimeFactors(number / div, newprimes)
    }

//    val number = 13195
    val number = 600851475143L
    val l = decomposeToPrimeFactors(number, List())
    l.foreach(println)

  }

}
