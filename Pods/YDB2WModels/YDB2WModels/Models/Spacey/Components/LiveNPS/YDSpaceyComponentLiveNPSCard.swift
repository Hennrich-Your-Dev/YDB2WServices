//
//  YDSpaceyComponentLiveNPSCard.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 21/06/21.
//

import UIKit

public class YDSpaceyComponentLiveNPSCard: Decodable {
  public var id: String?
  public var children: [YDSpaceyComponentLiveNPSCardQuestion]
  public var type: YDSpaceyComponentsTypes.Types = .liveNPSCardQuestion
  public var title: String?

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case children
    case type
    case title
  }

  public init(
    id: String?,
    children: [YDSpaceyComponentLiveNPSCardQuestion],
    title: String?
  ) {
    self.id = id
    self.children = children
    self.title = title
  }
}
