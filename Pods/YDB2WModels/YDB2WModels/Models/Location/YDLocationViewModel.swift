//
//  YDLocationViewModel.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 08/12/20.
//

import Foundation
import CoreLocation

public class YDLocationViewModel {
  public var address: String?
  public var location: CLLocationCoordinate2D?
  public var store: YDStore?

  // MARK: Init
  public init(
    address: String,
    location: CLLocationCoordinate2D?,
    store: YDStore?
  ) {
    self.address = address
    self.location = location
    self.store = store
  }
}
