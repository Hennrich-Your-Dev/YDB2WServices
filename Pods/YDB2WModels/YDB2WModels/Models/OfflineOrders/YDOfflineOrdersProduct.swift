//
//  YDOfflineOrdersProduct.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 11/03/21.
//
import Foundation

import YDExtensions

public class YDOfflineOrdersProduct: Decodable {
  // MARK: Properties
  private var item: String?
  public var howMany: Int = 1
  public var ean: String?
  public var totalPrice: Double
  public var products: YDProductOnlineOffline? {
    didSet {
      products?.online?.ean = ean
      products?.offline?.ean = ean
      products?.offline?.name = products?.offline?.name ?? item
      products?.offline?.price = products?.offline?.price ?? totalPrice
    }
  }

  // MARK: Computed variables
  public var formatedPrice: String? {
    return totalPrice.formatedPrice
  }

  public var image: String? {
    return products?.online?.images?.first?.medium
  }

  public var name: String? {
    return products?.online?.name ??
      products?.offline?.name ??
      self.item
  }

  // MARK: Coding Keys
  enum CodingKeys: String, CodingKey {
    case item
    case ean
    case howMany = "qtde"
    case totalPrice = "valorTotalItem"
  }
}
