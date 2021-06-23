//
//  YDSpaceyCustomCard.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 22/06/21.
//

import Foundation

public class YDSpaceyCustomCard: YDSpaceyCustomComponentDelegate {
  public var knewType: YDSpaceyCustomComponentType = .card
  public var id: String?
  public var children: [YDSpaceyComponentsTypes] = []
  public var type: YDSpaceyComponentsTypes.Types = .custom
  public var cards: [YDSpaceyComponentLiveNPSCard] = []

  public init(id: String?, cards: [YDSpaceyComponentLiveNPSCard]) {
    self.id = id
    self.cards = cards
  }

  public required init(from decoder: Decoder) throws {
    fatalError()
  }
}
