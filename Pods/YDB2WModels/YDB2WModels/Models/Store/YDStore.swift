//
//  YDStore.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 08/12/20.
//

import Foundation

import YDExtensions

public class YDStores: Decodable {
  public var stores: [YDStore]
}

public class YDStore: Decodable {
  // MARK: Properties
  public var id: String?
  public var name: String?
  public var sellerID: String?
  public var sellerStoreID: String?
  public var open: Bool?
  public var schedules: YDStoreOperatingDays?

  public var distance: Double?
  public var address: YDAddress?
  public var geolocation: YDStoreGeolocation?

  // MARK: Computed variables
  public var formatAddress: String {
    guard let address = self.address
    else { return "" }

    return address.formatAddress
  }

  public var formatDistance: String {
    guard let distance = distance else { return "" }
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
    calendar.locale = Locale(identifier: "en-US") // Need to be English since we compare with english day week name

    let weekDays = calendar.weekdaySymbols
    guard let todayWeekDay = weekDays.at(calendar.component(.weekday, from: Date()) - 1),
          let todayStruct = schedules[todayWeekDay]
    else {
      return ""
    }

    if let start = todayStruct.start {
      if let end = todayStruct.end {
        return "\(start)h às \(end)h"
      }

      return "A partir das \(start)h"
    }

    return ""
  }

  public func addressAndStoreName() -> String {
    guard let unwarpAddress = self.address,
          var address = unwarpAddress.address,
          let name = self.name
    else { return "" }

    if let number = unwarpAddress.number,
       !number.isEmpty {
      address += ", " + number
    }

    return [address, name].filter { !($0).isEmpty }.joined(separator: " : ")
  }

  public func isLasa(metersCondition: Double) -> Bool {
    guard let distance = distance else { return false }
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

  // MARK: Init
  public init(
    id: String? = nil,
    name: String? = nil,
    sellerID: String? = nil,
    sellerStoreID: String? = nil,
    open: Bool? = nil,
    schedules: YDStoreOperatingDays? = nil,
    distance: Double? = nil,
    address: YDAddress? = nil,
    geolocation: YDStoreGeolocation? = nil
  ) {
    self.id = id
    self.name = name
    self.sellerID = sellerID
    self.sellerStoreID = sellerStoreID
    self.open = open
    self.schedules = schedules
    self.distance = distance
    self.address = address
    self.geolocation = geolocation
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
