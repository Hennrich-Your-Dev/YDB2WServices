//
//  YDSpaceyComponentLiveNPS.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 05/07/21.
//

import Foundation

public class YDSpaceyComponentLiveNPS: YDSpaceyComponentDelegate {
  // MARK: Properties
  public var id: String?
  public var type: YDSpaceyComponentsTypes.Types
  public var children: [YDSpaceyComponentsTypes]
  public var cards: [YDSpaceyComponentLiveNPSCard]

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case type
    case children
  }

  // MARK: Init
  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    type = try container.decode(YDSpaceyComponentsTypes.Types.self, forKey: .type)
    children = []

    let throwables = try? container.decode(
      [Throwable<YDSpaceyComponentLiveNPSCard>].self,
      forKey: .children
    )
    cards = throwables?.compactMap { try? $0.result.get() } ?? []

    // Optionals
    id = try? container.decode(String.self, forKey: .id)
  }

  public init(
    id: String?,
    cards: [YDSpaceyComponentLiveNPSCard]
  ) {
    self.id = id
    self.cards = cards

    self.type = .liveNPS
    self.children = []
  }
}
