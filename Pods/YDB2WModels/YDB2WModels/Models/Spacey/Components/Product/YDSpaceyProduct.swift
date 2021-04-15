//
//  YDSpaceyProduct.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 14/04/21.
//

import Foundation

public class YDSpaceyProduct: Codable {
  public var description: String?
  public var id: String?
  public var images: [String]?
  public var name: String?
  public var price: String?
  public var priceConditions: String?
  public var ean: String?
  public var rating: YDSpaceyProductRating?
  public var partnerId: String?
  public var stock: Bool = false
  public var onBasket: Bool = true

  public var productAvailable: Bool {
    if stock || price != nil || ean != nil {
      return true
    }

    return false
  }

  public init(
    description: String? = nil,
    id: String? = nil,
    images: [String]? = nil,
    name: String? = nil,
    price: String? = nil,
    priceConditions: String? = nil,
    ean: String? = nil,
    rating: YDSpaceyProductRating? = nil,
    partnerId: String? = nil,
    stock: String? = nil,
    onBasket: Bool = false
  ) {
    self.description = description
    self.id = id
    self.images = images
    self.name = name
    self.price = price
    self.priceConditions = priceConditions
    self.ean = ean
    self.rating = rating
    self.partnerId = partnerId
    self.onBasket = onBasket
    self.stock = stock == "true"
  }

  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    description = try? container.decode(
      String.self,
      forKey: .description
    )

    id = try? container.decode(
      String.self,
      forKey: .id
    )

    images = try? container.decode(
      [String].self,
      forKey: .images
    )

    name = try? container.decode(
      String.self,
      forKey: .name
    )

    price = try? container.decode(
      String.self,
      forKey: .price
    )

    priceConditions = try? container.decode(
      String.self,
      forKey: .priceConditions
    )

    ean = try? container.decode(
      String.self,
      forKey: .ean
    )

    rating = try? container.decode(
      YDSpaceyProductRating.self,
      forKey: .rating
    )

    partnerId = try? container.decode(String.self, forKey: .partnerId)

    if let stockString = try? container.decode(String.self, forKey: .stock) {
      stock = stockString == "true"
    } else {
      stock = false
    }

    onBasket = false
  }

  public static func mock() -> YDSpaceyProduct {
    return YDSpaceyProduct()
  }
}

public struct YDSpaceyProductRating: Codable {
  public let average: Double
  public let recommendations: Int
  public let reviews: Int

  public init(average: Double, recommendations: Int, reviews: Int) {
    self.average = average
    self.recommendations = recommendations
    self.reviews = reviews
  }
}
