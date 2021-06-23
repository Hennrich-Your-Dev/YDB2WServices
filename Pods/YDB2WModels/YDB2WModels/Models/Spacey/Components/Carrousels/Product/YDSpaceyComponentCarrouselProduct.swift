//
//  YDSpaceyComponentCarrouselProduct.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 12/05/21.
//

import Foundation

public class YDSpaceyComponentCarrouselProduct: YDSpaceyComponentDelegate {
  public var id: String?
  public var children: [YDSpaceyComponentsTypes]
  public var type: YDSpaceyComponentsTypes.Types
  public var showcaseTitle: String?
  public var productsList: [Int: YDSpaceyProductCarrouselContainer] = [:]

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case children
    case type
    case showcaseTitle
  }

  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try? container.decode(String.self, forKey: .id)
    type = try container.decode(YDSpaceyComponentsTypes.Types.self, forKey: .type)

    let throwables = try? container.decode(
      [Throwable<YDSpaceyComponentsTypes>].self,
      forKey: .children
    )
    children = throwables?.compactMap { try? $0.result.get() } ?? []

    showcaseTitle = try? container.decode(String.self, forKey: .showcaseTitle)
  }
}
