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
  // MARK: Properties
  public var messages: [YDChatMessage]

  public var fixedMessage: YDChatMessage?

  // MARK: Init
  public init() {
    messages = []
    fixedMessage = nil
  }

  public init(messages: [YDChatMessage], fixedMessage: YDChatMessage? = nil) {
    self.messages = messages
    self.fixedMessage = fixedMessage
  }
}

public class YDChatMessage: Codable {
  // MARK: Properties
  public var id: String?
  public var message: String
  public var date: String?
  public let resource: YDChatMessageResource?
  public let sender: YDChatMessageSender
  public var repliedMessage: YDChatMessage?
  public var repliedMessageId: String?

  // MARK: Computed variables
  public var hourAndMinutes: String {
    let date = self.date ?? Date().iso8601String
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
    date: String?,
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
    case repliedMessage
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

    return YDChatMessage(
      message: message,
      date: nil,
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

// MARK: Equatable
extension YDChatMessage: Equatable {
  public static func == (lhs: YDChatMessage, rhs: YDChatMessage) -> Bool {
    return lhs.id == rhs.id
  }
}
