//
//  YDSpaceyCommonComponent.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 12/05/21.
//

import Foundation

public class YDSpaceyCommonComponent: YDSpaceyComponentDelegate {
  // MARK: Properties
  public var id: String?
  public var children: [YDSpaceyComponentsTypes]
  public var type: YDSpaceyComponentsTypes.Types

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case children
    case type
  }

  // MARK: Init
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
  }

  public init(
    id: String? = nil,
    children: [YDSpaceyComponentsTypes] = [],
    type: YDSpaceyComponentsTypes.Types
  ) {
    self.id = id
    self.children = children
    self.type = type
  }
}
