//
//  YDSpacey.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 14/04/21.
//

import Foundation
import YDExtensions

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
