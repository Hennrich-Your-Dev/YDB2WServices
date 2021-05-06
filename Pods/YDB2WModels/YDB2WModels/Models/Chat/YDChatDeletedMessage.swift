//
//  YDChatDeletedMessage.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 05/05/21.
//

import Foundation

public class YDChatDeletedMessages: Decodable {
  public var ids: [String]?

  public init(ids: [String]?) {
    self.ids = ids
  }
}

public struct YDChatDeletedMessageStruct {
  public let messageId: String
  public let index: Int

  public init(messageId: String, index: Int) {
    self.messageId = messageId
    self.index = index
  }
}
