package net.gsarchives.gsa4to5

import java.nio.file.Path

package object output {

  case class GroupId(x: Int)

  sealed trait Group {
    def id: GroupId
  }

  case class Folder(
    id: GroupId,
    path: Path,
    parentId: Option[GroupId],
    name: String,
    display: String,
    order: Int
  )

  case class Section(
    id: GroupId,
    path: Path,
    parentId: GroupId,
    display: String,
    order: Int
  )

  case class ImageId(x: Int)

  case class SubmitterId(x: Int)

  case class Image(
    id: ImageId,
    groupId: GroupId,
    path: Path,
    submitterId: SubmitterId,
    name: String,
    display: String,
    extension: String
  )
}
