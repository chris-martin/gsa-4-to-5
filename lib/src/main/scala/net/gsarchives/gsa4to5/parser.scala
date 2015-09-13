package net.gsarchives.gsa4to5

import org.joda.time.DateTime

package object parser {

  sealed trait PageChild
  sealed trait SectionChild

  case class Page(name: String, display: String, children: Seq[PageChild]) extends PageChild with SectionChild

  case class Section(display: String, children: Seq[SectionChild]) extends PageChild

  case class Image(name: String, submitterId: SubmitterId, date: DateTime) extends PageChild with SectionChild

  case class SubmitterId(x: Int)

  import scala.util.parsing.combinator._

  class Parser extends RegexParsers {

    def page(depth: Int): Parser[Page] =
      repN(depth, " ") ~> "@([^,\n]+)".r <~ "," ~> "([^,\n]+)\n".r ~ rep(pageChild(depth + 1)) ^^
      { case (display, name, children) => Page(display=display, name=name, children=children) }

    def pageChild(depth: Int): Parser[PageChild] =
      repN(depth, " ") ~> (page(depth) | section(depth) | image(depth)) ^^
      { case _ => ??? }

    def section(depth: Int): Parser[Section] =
      sectionHeader(depth) ~ rep(sectionChild(depth)) ^^
        { case (display, children) => Section(display, children) }

    def sectionHeader(depth: Int): Parser[String] =
      repN(depth, " ") ~> "#" ~> "([^\n]*)\n".r

    def sectionChild(depth: Int): Parser[SectionChild] =
      repN(depth, " ") ~> (page(depth) | section(depth) | image(depth))


  }
}
