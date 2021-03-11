//
//  YDStore.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 08/12/20.
//

import Foundation

import YDExtensions

public class YDStores: Decodable {
  public let stores: [YDStore]
}

public class YDStore: Decodable {

  // MARK: Properties
  public let id: String
  public let name: String
  public let sellerID: String
  public let sellerStoreID: String
  public let open: Bool
  public let schedules: YDStoreOperatingDays?

  public let distance: Double
  public let address: YDAddress?
  public let geolocation: YDStoreGeolocation?

  // MARK: Computed variables
  public var formatAddress: String {
    guard let address = self.address
    else { return "" }

    return address.formatAddress
  }

  public var formatDistance: String {
    let kilometers = Measurement(value: distance, unit: UnitLength.kilometers)
    let meters = kilometers.converted(to: .meters)
    let formated = meters.value >= 1000 ?
      "\(kilometers.value.round(to: 1)) \(kilometers.unit.symbol)" :
      "\(meters.value.round(to: 1)) \(meters.unit.symbol)"
    return formated
  }

  public var currentOperatingTime: String {
    guard let schedules = schedules else {
      return ""
    }

    var calendar = Calendar.init(identifier: .gregorian)
    calendar.locale = Locale(identifier: "en-US")

    let weekDays = calendar.weekdaySymbols
    guard let todayWeekDay = weekDays.at(calendar.component(.weekday, from: Date()) - 1),
          let todayStruct = schedules[todayWeekDay]
    else {
      return ""
    }

    if let start = todayStruct.start {
      if let end = todayStruct.end {
        return "\(start) ás \(end)"
      }

      return "A partir das \(start)"
    }

    return ""
  }

  public func addressAndStoreName() -> String {
    guard let unwarpAddress = self.address,
          var address = unwarpAddress.address
    else { return "" }

    let name = self.name

    if let number = unwarpAddress.number,
       !number.isEmpty {
      address += ", " + number
    }

    return [address, name].filter { !($0).isEmpty }.joined(separator: " : ")
  }

  public func isLasa(metersCondition: Double) -> Bool {
    // Convert KM to Meters
    let currentDistance = Measurement(value: distance, unit: UnitLength.kilometers)
    let meters = currentDistance.converted(to: .meters)
    return meters.value <= metersCondition
  }

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case sellerID = "sellerId"
    case sellerStoreID = "sellerStoreId"
    case open
    case schedules
    case distance
    case address
    case geolocation
  }
}

// MARK: Geolocation
public class YDStoreGeolocation: Decodable {
  public let latitude, longitude: Double?
}

// MARK: YDStoreOperatingDays
public class YDStoreOperatingDays: Decodable {
  let monday: YDStoreOperatingDaysStruct?
  let tuesday: YDStoreOperatingDaysStruct?
  let wednesday: YDStoreOperatingDaysStruct?
  let thursday: YDStoreOperatingDaysStruct?
  let friday: YDStoreOperatingDaysStruct?
  let saturday: YDStoreOperatingDaysStruct?
  let sunday: YDStoreOperatingDaysStruct?

  subscript(_ key: String) -> YDStoreOperatingDaysStruct? {
    switch key.lowercased() {
    case "monday":
      return monday
    case "tuesday":
      return tuesday
    case "wednesday":
      return wednesday
    case "thursday":
      return thursday
    case "friday":
      return friday
    case "saturday":
      return saturday
    case "sunday":
      return sunday
    default:
      return nil
    }
  }
}

public class YDStoreOperatingDaysStruct: NSObject, Decodable {
  let start: String?
  let end: String?
}

// MARK: Extension
extension Double {
  func round(to places: Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}
