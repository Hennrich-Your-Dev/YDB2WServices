//
//  YDProductAttributes.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 25/03/21.
//

import Foundation

public struct YDProductAttributesContainer: Codable {
  public let properties: [YDProductAttributes]?
  public let title: String?

  public init(title: String?, properties: [YDProductAttributes]?) {
    self.title = title
    self.properties = properties
  }
}

public struct YDProductAttributes: Codable {
  public let name: String
  public let value: String

  public init(name: String, value: String) {
    self.name = name
    self.value = value
  }
}
