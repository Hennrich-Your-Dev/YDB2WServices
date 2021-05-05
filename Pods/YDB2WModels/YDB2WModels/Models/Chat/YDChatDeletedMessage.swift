//
//  YDChatDeletedMessage.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 05/05/21.
//

import Foundation

public class YDChatDeletedMessage: Decodable {
  public var ids: [String]?
}

public struct YDChatDeletedMessageStruct {
  public let messageId: String
  public let index: Int
}
