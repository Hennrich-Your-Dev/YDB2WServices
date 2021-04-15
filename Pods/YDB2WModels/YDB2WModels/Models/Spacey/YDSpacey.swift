//
//  YDSpacey.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 14/04/21.
//

import Foundation

import YDUtilities

public class YDSpacey: Decodable {
  // MARK: Properties
  public var items: [String: YDSpaceyCommonStruct?]

  // MARK: Init
  public required init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()

    items = try container.decode([String: YDSpaceyCommonStruct?].self)
  }

  // MARK: Actions
  public subscript(key: String) -> YDSpaceyCommonStruct? {
    return items[key] as? YDSpaceyCommonStruct
  }

  public func allComponents() -> [YDSpaceyCommonStruct] {
    return items.map { (key: String, value: YDSpaceyCommonStruct?) -> YDSpaceyCommonStruct? in
      return value
    }.compactMap { $0 }
  }
}

// MARK: Common Struct
public class YDSpaceyCommonStruct: Decodable {
  public let id: String?
  public let component: YDSpaceyCommonComponent

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case component
  }

  public init(id: String?, component: YDSpaceyCommonComponent) {
    self.id = id
    self.component = component
  }
}

// MARK: Common Component
public class YDSpaceyCommonComponent: Decodable {
  public let id: String?
  public let children: [YDSpaceyComponentsTypes]?
  public let type: String?
  public let showcaseTitle: String?

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case children
    case type
    case showcaseTitle
  }

  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let throwables = try? container.decode(
      [Throwable<YDSpaceyComponentsTypes>].self,
      forKey: .children
    )
    children = throwables?.compactMap { try? $0.result.get() }

    // Optionals
    id = try? container.decode(String.self, forKey: .id)
    type = try? container.decode(String.self, forKey: .type)
    showcaseTitle = try? container.decode(String.self, forKey: .showcaseTitle)
  }

  public init(
    id: String?,
    children: [YDSpaceyComponentsTypes]?,
    type: String?,
    showcaseTitle: String?
  ) {
    self.id = id
    self.children = children
    self.type = type
    self.showcaseTitle = showcaseTitle
  }
}

