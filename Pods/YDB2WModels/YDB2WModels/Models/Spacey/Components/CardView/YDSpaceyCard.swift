//
//  YDSpaceyCard.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 11/06/21.
//

import UIKit

public class YDSpaceyCard {
  // MARK: Properties
  public var id: String?
  public var title: String?
  public var cards: [YDSpaceyInnerCard]

  // MARK: Init
  public init(
    id: String?,
    title: String?,
    cards: [YDSpaceyInnerCard]
  ) {
    self.id = id
    self.title = title
    self.cards = cards
  }
}

public class YDSpaceyInnerCard {
  // MARK: Properties
  public var id: String?
  public var title: String?
  public var icon: UIImage?

  // MARK: Init
  public init(
    id: String?,
    title: String?,
    icon: UIImage?
  ) {
    self.id = id
    self.title = title
    self.icon = icon
  }
}
