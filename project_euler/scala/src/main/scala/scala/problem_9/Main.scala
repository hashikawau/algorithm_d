package scala.problem_9

/**
 * Special Pythagorean triplet
 * Problem 9
 *
 * A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
 * a2 + b2 = c2
 *
 * For example, 32 + 42 = 9 + 16 = 25 = 52.
 *
 * There exists exactly one Pythagorean triplet for which a + b + c = 1000.
 * Find the product abc.
 *
 */
object Main {
  def main(args: Array[String]): Unit = {
    def getPytagorean(twoNumbers: Seq[Int]): Option[Tuple3[Int, Int, Int]] = {
      //      val a = twoNumbers._1
      //      val b = twoNumbers._2
      val a = twoNumbers(0)
      val b = twoNumbers(1)
      val square = a * a + b * b
      val root = math.sqrt(square).toInt

      if (square == root * root) Some((a, b, root))
      else None
    }

//    val maxNumber = 12
    val maxNumber = 1000
    val l = Stream.from(1)
      .takeWhile { _ <= maxNumber - 2 }
      .combinations(2)
      .map(getPytagorean)
//      .filter(_ != None)
      .filter((x) => x match {
        case Some(Tuple3(a, b, c)) => a+b+c == maxNumber
        case None => false
      })
//    l.foreach(println)
    
      l.next match{
        case Some(Tuple3(a, b, c)) => println("result: %d".format(a * b * c))
        case _ => {}
      }
//    Tuple3(a, b, c) = l.next.get
//    val a = l.next.get
//    println("result: %s".format(a))

  }

}