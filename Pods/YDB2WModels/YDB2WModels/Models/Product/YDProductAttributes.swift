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
}

public struct YDProductAttributes: Codable {
  public let name: String
  public let value: String
}
