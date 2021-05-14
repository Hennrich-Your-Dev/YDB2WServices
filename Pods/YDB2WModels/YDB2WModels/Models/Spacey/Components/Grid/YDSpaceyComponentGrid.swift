//
//  YDSpaceyComponentGrid.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 10/05/21.
//

import Foundation

import YDUtilities

public class YDSpaceyComponentGrid: YDSpaceyComponentDelegate {
  // MARK: Properties
  public var id: String?
  public var type: YDSpaceyComponentsTypes.Types
  public var children: [YDSpaceyComponentsTypes]
  public let layout: YDSpaceyComponentGridLayout

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case type
    case children
    case layout = "xs"
  }

  // MARK: Init
  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try? container.decode(String.self, forKey: .id)

    type = try container.decode(YDSpaceyComponentsTypes.Types.self, forKey: .type)

    let throwables = try? container.decode(
      [Throwable<YDSpaceyComponentsTypes>].self,
      forKey: .children
    )
    children = throwables?.compactMap { try? $0.result.get() } ?? []

    if let typeDecoded = try? container.decode(YDSpaceyComponentGridLayout.self, forKey: .layout) {
      layout = typeDecoded
    } else {
      layout = .vertical
    }
  }
}

// MARK: Grid layout
public enum YDSpaceyComponentGridLayout: String, Decodable {
  case vertical = "1"
  case horizontal = "2"
}
