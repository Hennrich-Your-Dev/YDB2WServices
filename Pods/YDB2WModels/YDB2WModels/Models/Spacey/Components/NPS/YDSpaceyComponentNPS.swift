//
//  YDSpaceyComponentNPS.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 18/05/21.
//

import UIKit

public class YDSpaceyComponentNPS: YDSpaceyComponentDelegate {
  // MARK: Properties
  public var id: String?
  public var type: YDSpaceyComponentsTypes.Types
  public var children: [YDSpaceyComponentsTypes]
  public var cardTitle: String?
  public var previewQuantity: Int?

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case type
    case children
    case cardTitle
    case previewQuantity
  }

  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let throwables = try? container.decode(
      [Throwable<YDSpaceyComponentsTypes>].self,
      forKey: .children
    )
    children = throwables?.compactMap { try? $0.result.get() } ?? []

    // Optionals
    id = try? container.decode(String.self, forKey: .id)
    type = try container.decode(YDSpaceyComponentsTypes.Types.self, forKey: .type)
    cardTitle = try? container.decode(String.self, forKey: .cardTitle)
    previewQuantity = try? container.decode(Int.self, forKey: .previewQuantity)
  }
}
