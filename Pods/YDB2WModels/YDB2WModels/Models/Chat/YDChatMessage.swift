//
//  YDChatMessage.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 05/05/21.
//

import Foundation

import YDExtensions

public class YDChatMessagesListInterface: Codable {
  public let resource: YDChatMessagesList
}

public class YDChatMessagesList: Codable {
  public var messages: [YDChatMessage]

  public init() {
    messages = []
  }

  public init(messages: [YDChatMessage]) {
    self.messages = messages
  }
}

public class YDChatMessage: Codable {
  // MARK: Properties
  public var id: String?
  public var message: String
  public let date: String
  public let resource: YDChatMessageResource?
  public let sender: YDChatMessageSender

  public var hourAndMinutes: String {

    let dateFormatterGet = ISO8601DateFormatter()
    dateFormatterGet.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

    let dateFormatterHourAndMinutes = DateFormatter()
    dateFormatterHourAndMinutes.dateFormat = "HH:mm"

    if let dateFromString = dateFormatterGet.date(from: date) {
      return dateFormatterHourAndMinutes.string(from: dateFromString)
    } else {
       return ""
    }
  }

  public var recentAdded: Bool = false

  public var deletedMessage: Bool = false

  // MARK: Init
  public init(
    message: String,
    date: String,
    videoId: String,
    sender: YDChatMessageSender
  ) {
    self.message = message
    self.date = date
    self.resource = YDChatMessageResource(id: videoId)
    self.sender = sender
  }

  //
  enum CodingKeys: String, CodingKey {
    case id
    case message = "text"
    case date = "created_at"
    case resource
    case sender
  }

  // MARK: Action
  public static func createMessage(
    _ message: String,
    customer: YDCurrentCustomer,
    videoId: String
  ) -> YDChatMessage {
    let sender = YDChatMessageSender(
      id: customer.id,
      name: customer.fullName ?? "",
      avatar: nil
    )

    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

    let date = formatter.string(from: Date())

    return YDChatMessage(
      message: message,
      date: date,
      videoId: videoId,
      sender: sender
    )
  }
}

public class YDChatMessageResource: Codable {
  public var id: String
  public var type: String

  public init(id: String) {
    self.id = id
    self.type = "live"
  }
}

public class YDChatMessageSender: Codable {
  public let id: String
  public let name: String
  public let avatar: String?

  public init(
    id: String,
    name: String,
    avatar: String?
  ) {
    self.id = id
    self.name = name
    self.avatar = avatar
  }
}
