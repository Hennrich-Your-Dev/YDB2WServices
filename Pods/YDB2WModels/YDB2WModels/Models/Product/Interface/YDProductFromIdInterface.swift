//
//  YDProductFromIdInterface.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 23/05/21.
//

import Foundation

public class YDProductFromIdInterface: Decodable {
  public let partnerId: String?
  public let productId: String
  public let name: String
  public let description: String
  public let images: [String]?
  public let rating: Double?
  public let numReviews: Int?
  public let price: String?
  public let priceConditions: String?
  public let ean: String?
  public let stock: String?

  enum CodingKeys: String, CodingKey {
    case partnerId
    case productId = "prodId"
    case name
    case description
    case images
    case rating
    case numReviews
    case price
    case priceConditions = "installment"
    case ean = "productSku"
    case stock
  }
}
