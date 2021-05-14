//
//  YDSpaceyComponentTitle.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 10/05/21.
//

import Foundation

public class YDSpaceyComponentTitle: Decodable {
  // MARK: Properties
  public let id: String
  public var title: String?
  public var contentTitle: String?
  public let componentType: YDSpaceyComponentsTypes.Types = .title

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case title
    case contentTitle
  }

  // MARK: Init
  public init(
    id: String,
    title: String? = nil,
    contentTitle: String? = nil
  ) {
    self.id = id
    self.title = title
    self.contentTitle = contentTitle
  }
}
