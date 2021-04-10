//
//  YDProductB2W.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 26/03/21.
//

import Foundation

import YDUtilities

public class YDProductB2W: Codable {
  private var results: [YDProductB2WResult]
  public var products: [YDProduct]?

  // CodingKeys
  enum CodingKeys: String, CodingKey {
    case results = "result"
  }

  //
  required public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = []

    if let throwablesMoreProducts = try? container.decode(
      [[Throwable<YDProductB2WResult>]].self,
      forKey: .results
    ) {
      throwablesMoreProducts.forEach {
        switch $0.first?.result {
          case .success(let result):
            results.append(result)

          case .failure(let error as NSError):
            debugPrint(#function, error.debugDescription)
            results.append(YDProductB2WResult.empty())
          case .none:
            break
        }
      }
    } else if let throwablesOneProduct = try? container.decode(
      [Throwable<YDProductB2WResult>].self,
      forKey: .results
    ) {
      throwablesOneProduct.forEach {
        switch $0.result {
          case .success(let result):
            results.append(result)

          case .failure(let error as NSError):
            debugPrint(#function, #line, "\n", error.debugDescription)
            results.append(YDProductB2WResult.empty())
        }
      }
    }

    products = results.enumerated().map { (index, result) in
      if result.id != nil {
        var price: Double?

        if let offer = result.offer?.offers?.first {
          price = offer.salesPrice
        }

        return YDProduct(
          attributes: result.attributes,
          description: result.description,
          id: result.id,
          images: result.images,
          name: result.name,
          price: price,
          rating: result.rating,
          isAvailable: price != nil
        )

      } else {
        return YDProduct(
          attributes: nil,
          description: nil,
          id: nil,
          images: nil,
          name: nil,
          price: nil,
          rating: nil,
          isAvailable: false
        )
      }
    }
  }
}

public class YDProductB2WOffers: Codable {
  public let offers: [YDProductB2WOffer]?

  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    offers = try container.decode([YDProductB2WOffer].self, forKey: .offers)
  }

}

public class YDProductB2WOffer: Codable {
  public let salesPrice: Double
}

public class YDProductB2WResult: YDProduct {
  public let offer: YDProductB2WOffers?

  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    offer = try container.decode(YDProductB2WOffers.self, forKey: .offer)
    try super.init(from: decoder)
  }

  init() {
    self.offer = nil
    super.init(
      attributes: nil,
      description: nil,
      id: nil,
      images: nil,
      name: nil,
      price: nil,
      rating: nil
    )
  }

  enum CodingKeys: CodingKey {
    case offer
  }

  public static func empty() -> YDProductB2WResult {
    return YDProductB2WResult.init()
  }
}
