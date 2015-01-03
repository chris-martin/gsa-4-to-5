name := "gsa4to5"

version in ThisBuild := "0.0"

organization in ThisBuild := "net.gsarchives"

scalaVersion in ThisBuild := "2.11.4"

scalacOptions in ThisBuild ++= Seq("-deprecation", "-feature")

lazy val lib = project in file("lib")

lazy val app = project in file("app") dependsOn lib
