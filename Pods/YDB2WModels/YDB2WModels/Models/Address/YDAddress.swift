//
//  YDAddress.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 08/12/20.
//

import UIKit
import CoreLocation

public class YDAddress: Decodable {
  public var type: YDAddressType?

  public var postalCode: String?

  public let address: String?
  public let number: String?
  public let complement: String?

  public let neighborhood: String?
  public let city: String?
  public let state: String?

  public let longitude: Double?
  public let latitude: Double?

  // MARK: Computed variables
  public var formatAddress: String {
    guard var address = address else {
      return ""
    }

    if let number = number,
       !number.isEmpty {
      address += ", \(number)"
    }

    if let complement = complement,
       !complement.isEmpty {
      address += ", \(complement)"
    }

    if let city = city,
       !city.isEmpty {
      address += ", \(city)"
    }

    if let state = state,
       !state.isEmpty {
      address += " - \(state)"
    }

    return address
  }

  public var coords: CLLocationCoordinate2D? {
    guard let latitude = latitude,
          let longitude = longitude
    else {
      return nil
    }

    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }

  // MARK: Init
  public init(
    type: YDAddressType? = nil,
    postalCode: String? = nil,
    address: String? = nil,
    number: String? = nil,
    complement: String? = nil,
    city: String? = nil,
    state: String? = nil,
    neighborhood: String? = nil,
    latitude: Double? = nil,
    longitude: Double? = nil
  ) {
    self.type = type
    self.postalCode = postalCode
    self.address = address
    self.number = number
    self.complement = complement
    self.city = city
    self.state = state
    self.neighborhood = neighborhood
    self.latitude = latitude
    self.longitude = longitude
  }

  public init(savedAddress: [String: String]) {
    if let type = savedAddress["type"] {
      switch type {
      case YDAddressType.location.rawValue:
        self.type = .location
      case YDAddressType.search.rawValue:
        self.type = .search
      case YDAddressType.customer.rawValue:
        self.type = .customer
      default:
        self.type = .unknown
      }
    } else {
      self.type = .unknown
    }

    self.postalCode = savedAddress["cep"]

    self.address = savedAddress["text"]

    if let latitudeString = savedAddress["latitude"],
       let latitude = Double(latitudeString),
       let longitudeString = savedAddress["longitude"],
       let longitude = Double(longitudeString) {
      self.latitude = latitude
      self.longitude = longitude

      //
    } else {
      self.latitude = nil
      self.longitude = nil
    }

    self.city = savedAddress["city"]
    self.state = savedAddress["state"]

    self.number = nil
    self.complement = nil
    self.neighborhood = nil
  }
}

public enum YDAddressType: String, CaseIterable, Decodable {
  case search = "SEARCH_CEP"
  case location = "GPS"
  case customer = "CUSTOMER_ADDRESS"

  case unknown = "UNKNOWN"
}
