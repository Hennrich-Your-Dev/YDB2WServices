//
//  YDProductImage.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 25/03/21.
//

import Foundation

public struct YDProductImage: Codable {
  public let big: String?
  public let extraLarge: String?
  public let large: String?
  public let medium: String?
  public let small: String?

  public init(
    big: String? = nil,
    extraLarge: String? = nil,
    large: String? = nil,
    medium: String? = nil,
    small: String? = nil
  ) {
    self.big = big
    self.extraLarge = extraLarge
    self.large = large
    self.medium = medium
    self.small = small
  }
}
