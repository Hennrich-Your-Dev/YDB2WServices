//
//  YDSpaceyComponentProduct.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 14/04/21.
//

import Foundation

public class YDSpaceyComponentProduct: Decodable {
  public let id: String
  public let productId: String
  public let componentType: YDSpaceyComponentsTypes.Types = .product

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case productId
  }
}
