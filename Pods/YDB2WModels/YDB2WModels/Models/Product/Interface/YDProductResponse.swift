//
//  YDProductResponse.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 26/03/21.
//

import Foundation

public class YDProductResponse: Codable {
  // CodingKeys
  enum CodingKeys: String, CodingKey {
    case offersB2W = "product-b2w"
    case offersLasa = "product-lasa"
  }

  // Properties
  var offersB2W: [YDProduct]
  var offersLasa: [YDProduct]

  // Init from decoder
  required public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    offersB2W = try container.decode(YDProductB2W.self, forKey: .offersB2W).products ?? []
    offersLasa = try container.decode(YDProductLasa.self, forKey: .offersLasa).products ?? []

    for (index, product) in offersLasa.enumerated() {
      guard let currentB2W = offersB2W.at(index) else { continue }

      offersLasa[index].id = currentB2W.id
      offersLasa[index].attributes = currentB2W.attributes
      offersLasa[index].description = currentB2W.description
      offersLasa[index].images = currentB2W.images
      offersLasa[index].name = currentB2W.name
      offersLasa[index].price = product.price ?? currentB2W.price
      offersLasa[index].rating = currentB2W.rating
      offersLasa[index].isAvailable = product.price != nil
    }
  }
}
