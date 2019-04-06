
lazy val root = (project in file(".")).
  settings(
    name := "scala",
    version := "1.0",
    scalaVersion := "2.11.6"
  )

resolvers += "Akka Snapshot Repository" at "http://repo.akka.io/snapshots/"

libraryDependencies +=
  "com.typesafe.akka" % "akka-actor_2.11" % "2.3.11"

//libraryDependencies ++= Seq(
//  "com.typesafe.akka" %% "akka-actor" % "2.4-SNAPSHOT"
//)

