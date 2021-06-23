//
//  YDSpaceyComponentTermsOfUse.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 04/06/21.
//

import UIKit

public class YDSpaceyComponentTermsOfUse: YDSpaceyComponentDelegate {
  // MARK: Properties
  public var id: String?
  public var type: YDSpaceyComponentsTypes.Types
  public var children: [YDSpaceyComponentsTypes] = []
  public var contentJson: String?

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case type
    case children
    case contentJson
  }

  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    type = try container.decode(YDSpaceyComponentsTypes.Types.self, forKey: .type)

    // Optionals
    id = try? container.decode(String.self, forKey: .id)
    contentJson = try? container.decode(String.self, forKey: .contentJson)
  }
}
