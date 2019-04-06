package scala.problem_5

import scala.annotation.tailrec

/**
 * Smallest multiple
 * Problem 5
 *
 * 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
 *
 * What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
 *
 */
object Main {
  def main(args: Array[String]): Unit = {
    //---------------------------------
    //
    //---------------------------------
    def decomposeToPrimeFactors(n: Int): List[Int] = {
      @tailrec
      def helper(n: Int, primes: List[Int]): List[Int] = {
        val prime = Stream.from(2).filter(n % _ == 0).head
        if (prime == n) (primes :+ prime).sorted
        else helper(n / prime, primes :+ prime)
      }

      helper(n, List())
    }

    //---------------------------------
    //
    //---------------------------------
    def createCountMap(list: Seq[Int]): Map[Int, Int] = {
      @tailrec
      def helper(list: Seq[Int], map: Map[Int, Int]): Map[Int, Int] = list match {
        case Nil => map
        case head :: tail => helper(tail, map + (head -> (map.getOrElse(head, 0) + 1)))
      }

      helper(list, Map[Int, Int]())
    }

    val l = (2 to 20)
      .map(decomposeToPrimeFactors)
      .map(createCountMap)
      .flatMap(_.toList)
    //    l.foreach(println)

    //---------------------------------
    //
    //---------------------------------
    def mergeMap(list: Seq[Tuple2[Int, Int]]): Map[Int, Seq[Int]] = {
      @tailrec
      def helper(list: Seq[Tuple2[Int, Int]], result: Map[Int, Seq[Int]]): Map[Int, Seq[Int]] = list match {
        case Seq(x) => result
        case Seq(x, xs @ _*) => {
          val seq = result.getOrElse(x._1, Seq[Int]()) :+ x._2
          helper(xs, result + (x._1 -> seq))
        }
      }

      helper(list, Map())
    }
    val ll = mergeMap(l).map { tup => (tup._1, tup._2.max) }
//    ll.foreach(println)

    //---------------------------------
    //
    //---------------------------------
    val result = ll.foldLeft(1) { (accum, tup) => accum * math.pow(tup._1, tup._2).toInt }
    println("result: %d".format(result))

  }

}