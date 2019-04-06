package scala.problem_10

/**
 * Summation of primes
 * Problem 10
 *
 * The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
 *
 * Find the sum of all the primes below two million.
 *
 */
object Main {
  def main(args: Array[String]): Unit = {
    val limit = 2000000
    //    val limit = 10
    //    import scala.problem_7.Main
    //    val l = scala.problem_7.Main.primeseq().takeWhile(_ < limit)
    //    l.foreach(println)
    //    println("result: %d".format(l.sum))
    //    def longstream(from: Long): Stream[Long] = {
    //      
    //    }

    //    val l = primeseq().take(10001)
    val l = primeseq().takeWhile(_ < limit)
    l.foreach(println)

    def summation(seq: Seq[Int], accum: Long): Long = seq match {
      case Seq(x) => accum + x
      case Seq(x, xs @ _*) => summation(xs, accum + x)
    }
    val sum = summation(l, 0)
    println("result: %d".format(sum))
  }

  def primeseq(): Stream[Int] = {
    Stream.from(2).filter(isprime)
  }

  def isprime(n: Int): Boolean = {
    Stream.from(2).takeWhile(_ <= math.sqrt(n).toInt).forall(n % _ != 0)
  }

}