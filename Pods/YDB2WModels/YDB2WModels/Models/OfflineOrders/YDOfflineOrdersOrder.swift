//
//  YDOfflineOrdersOrders.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 11/03/21.
//

import Foundation

import YDUtilities

public typealias YDOfflineOrdersOrdersList = [YDOfflineOrdersOrder]

public class YDOfflineOrdersOrder: Decodable {
  public var cupom: Int?
  public var nfe: String?
  public var date: String?
  public var totalPrice: Double?
  public var storeId: Int?
  public var storeName: String?

  // address
  public var addressStreet: String?
  public var addressCity: String?
  public var addressZipcode: String?
  public var addressState: String?

  // products
  public var products: [YDOfflineOrdersProduct]?

  // IndexPath
  public var indexPath: IndexPath?

  // computed variables
  public var formatedAddress: String? {
    guard var address = addressStreet else { return nil }

    if let city = addressCity,
       !city.isEmpty {
      address += " - \(city)"
    }

    if let cep = addressZipcode,
       !cep.isEmpty {
      address += " - \(cep)"
    }

    if let state = addressState,
       !state.isEmpty {
      address += ", \(state)"
    }

    return address
  }

  public var formatedDate: String? {
    return date?.date(withFormat: "yyyy-MM-dd'T'HH:mm:ss")?.toFormat("dd/MM/YYYY 'às' HH:mm'h'")
  }

  public var formatedDateSection: String? {
    return date?.date(withFormat: "yyyy-MM-dd'T'HH:mm:ss")?.toFormat("MMM 'de' YYYY")
  }

  public var dateWithDateType: Date? {
    guard let date = date else { return nil }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-DD'T'HH:mm:ss"

    return formatter.date(from: date)
  }

  public var formatedPrice: String? {
    guard let total = totalPrice else { return nil }
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "pt_BR")

    return formatter.string(from: NSNumber(value: total))
  }

  // MARK: Coding Keys
  enum CodingKeys: String, CodingKey {
    case cupom
    case nfe = "chaveNfe"
    case date = "data"
    case totalPrice = "valorTotal"
    case storeId = "codigoLoja"
    case storeName = "nomeLoja"
    case addressStreet = "logradouro"
    case addressZipcode = "cep"
    case addressCity = "cidade"
    case addressState = "uf"
    case products = "itens"
  }
}

// MARK: Mock
extension YDOfflineOrdersOrder {
  public static func mock() -> YDOfflineOrdersOrdersList {
    let bundle = Bundle(for: Self.self)

    guard let file = getLocalFile(bundle, fileName: "offlineOrders", fileType: "json"),
          let orders = try? JSONDecoder().decode(YDOfflineOrdersOrdersList.self, from: file)
      else {
      fatalError()
    }

    return orders
  }
}
