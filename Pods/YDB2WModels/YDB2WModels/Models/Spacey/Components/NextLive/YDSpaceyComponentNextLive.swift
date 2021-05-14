//
//  YDSpaceyComponentNextLive.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 27/04/21.
//

import Foundation

public class YDSpaceyComponentNextLive: Decodable {
  // MARK: Properties
  public let liveId: String?
  public let photo: String?
  public let initialDate: String?
  public let finalDate: String?
  public let name: String?
  public let description: String?
  public var alreadyScheduled = false
  public let componentType: YDSpaceyComponentsTypes.Types = .nextLive

  // MARK: Computed variables
  public var finalDateAsDate: Date? {
    finalDate?.date(withFormat: "dd/MM/yyyy HH:mm")
  }

  public var initialDateAsDate: Date? {
    initialDate?.date(withFormat: "dd/MM/yyyy HH:mm")
  }

  public var formatedDate: String? {
    guard let initialDateFormat = initialDate?.date(withFormat: "dd/MM/yyyy HH:mm"),
          let finalDateFormat = finalDate?.date(withFormat: "dd/MM/yyyy HH:mm")
    else { return nil }

    let startTime = initialDateFormat.toFormat("HH:mm")
    let endTime = finalDateFormat.toFormat("HH:mm")
    let now = Date()

    if initialDateFormat.isInToday &&
        now.isBetween(initialDateFormat, and: finalDateFormat) {
      return "ao vivo • \(startTime)-\(endTime)"
    } else {
      return "\(initialDateFormat.toFormat("dd/MM '•' ")) \(startTime)-\(endTime)"
    }
  }

  public var isAvailable: Bool {
    guard let initialDateFormat = initialDate?.date(withFormat: "dd/MM/yyyy HH:mm"),
          let finalDateFormat = finalDate?.date(withFormat: "dd/MM/yyyy HH:mm")
    else { return false }

    let now = Date()
    return !now.isBetween(initialDateFormat, and: finalDateFormat) && !alreadyScheduled
  }

  public var isLive: Bool {
    guard let initialDateFormat = initialDate?.date(withFormat: "dd/MM/yyyy HH:mm"),
          let finalDateFormat = finalDate?.date(withFormat: "dd/MM/yyyy HH:mm")
    else { return false }

    let now = Date()
    return now.isBetween(initialDateFormat, and: finalDateFormat)
  }

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case liveId = "_id"
    case photo = "liveImageUrl"
    case initialDate = "liveStartTime"
    case finalDate = "liveEndTime"
    case name = "title"
    case description = "liveDescription"
  }

  // MARK: Init
  public init(
    liveId: String? = nil,
    photo: String? = nil,
    initialDate: String? = nil,
    finalDate: String? = nil,
    name: String? = nil,
    description: String? = nil
  ) {
    self.liveId = liveId
    self.photo = photo
    self.initialDate = initialDate
    self.finalDate = finalDate
    self.name = name
    self.description = description
  }
}

// MARK: Mock
public extension YDSpaceyComponentNextLive {
  static func fromMock(
    id: String,
    startTime: String? = nil,
    endTime: String? = nil
  ) -> YDSpaceyComponentNextLive {
    return YDSpaceyComponentNextLive(
      liveId: id,
//      photo: "https://miro.medium.com/max/875/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg",
      initialDate: startTime ?? "27/04/2021 15:00",
      finalDate: endTime ?? "27/04/2021 16:00",
      name: "Nome da Live",
      description: .loremIpsum()
    )
  }
}
