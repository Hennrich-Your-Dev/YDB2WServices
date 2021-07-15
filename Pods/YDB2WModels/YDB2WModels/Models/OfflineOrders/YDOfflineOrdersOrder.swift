//
//  YDOfflineOrdersOrders.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 11/03/21.
//

import Foundation

public typealias YDOfflineOrdersOrdersList = [YDOfflineOrdersOrder]

public class YDOfflineOrdersOrder: Decodable {
  public var cupom: Int?
  public var nfe: String?
  public var date: String?
  public var totalPrice: Double?
  public var storeId: Int?

  // address
  public var addressStreet: String?
  public var addressCity: String?
  public var addressZipcode: String?
  public var addressState: String?
  public var storeName: String?

  // products
  public var products: [YDOfflineOrdersProduct]?
  public var alreadySearchOnAPI = false

  // IndexPath
  public var indexPath: IndexPath?

  // computed variables
  public var formattedStoreName: String? {
    return storeName?.capitalized
  }

  public var formattedAddress: String? {
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

    return address.capitalized
  }

  public var formattedDate: String? {
    return date?.date(withFormat: "yyyy-MM-dd'T'HH:mm:ss")?.toFormat("dd/MM/YYYY")
  }

  public var formattedDateSection: String? {
    return date?.date(withFormat: "yyyy-MM-dd'T'HH:mm:ss")?
      .toFormat("MMMM 'de' YYYY").lowercased(
        with: Locale(identifier: "pt_BR")
      )
  }

  public var dateWithDateType: Date? {
    return date?.date(withFormat: "yyyy-MM-dd'T'HH:mm:ss")
  }

  public var formattedPrice: String? {
    guard let total = totalPrice else { return nil }
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "pt_BR")

    return formatter.string(from: NSNumber(value: total))
  }

  public var strippedNFe: String? {
    guard let nfe = self.nfe else { return nil }
    return String(nfe.dropFirst(3))
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
