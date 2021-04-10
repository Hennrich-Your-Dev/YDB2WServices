//
//  YDProductsRESQL.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 03/04/21.
//

import Foundation

public class YDProductsRESQL: Codable {
  // MARK: Properties
  public var products: [YDProductOnlineOffline] = []

  // MARK: Init
  public required init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let results = try container.decode(YDProductResponse.self)

    products = results.offersB2W.map({ curr -> YDProductOnlineOffline in
      return YDProductOnlineOffline(online: curr, offline: nil)
    })

    for (index, productLasa) in results.offersLasa.enumerated() {
      if products.at(index) != nil {
        products[index].offline = productLasa
      }
    }
  }

  public init(withJson json: [String: Any]) {
    let results = YDProductResponse(withJson: json)

    products = results.offersB2W.map({ curr -> YDProductOnlineOffline in
      return YDProductOnlineOffline(online: curr, offline: nil)
    })

    for (index, productLasa) in results.offersLasa.enumerated() {
      if products.at(index) != nil {
        products[index].offline = productLasa
      }
    }
  }
}
