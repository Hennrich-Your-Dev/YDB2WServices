//
//  YDOfflineOrdersProduct.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 11/03/21.
//
import Foundation

public class YDOfflineOrdersProduct: Decodable {
  public var image: String?
  public var name: String?
  public var howMany: Int = 1
  public var ean: String?
  public var totalPrice: Double

  // MARK: Coding Keys
  enum CodingKeys: String, CodingKey {
    case image
    case name
    case ean
    case howMany = "qtde"
    case totalPrice = "valorTotalItem"
  }
}
