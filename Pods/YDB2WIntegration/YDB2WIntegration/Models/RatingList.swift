//
//  RatingList.swift
//  YDIntegration
//
//  Created by Douglas Hennrich on 11/11/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import Foundation

public class YDMNPSListConfig {
  // MARK: Properties
  public let uniqueId: String
  public var type: YDMNPSListType
  public let title: String

  public var items: [YDMNPSListConfigItems]?
  public var value: String?

  // MARK: Init
  public init(
    uniqueId: String,
    title: String,
    items: [YDMNPSListConfigItems]?,
    currentValue: String? = nil
  ) {
    self.uniqueId = uniqueId
    self.type = .largeHorizontal
    self.title = title
    self.items = items
    self.value = currentValue
  }
}

public class YDMNPSListConfigItems {
  public let value: String
  public var selected: Bool

  public init(value: String, selected: Bool = false) {
    self.value = value
    self.selected = selected
  }
}
