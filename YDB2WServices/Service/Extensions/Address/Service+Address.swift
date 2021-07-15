//
//  Service+Address.swift
//  YDB2WServices
//
//  Created by Douglas Hennrich on 15/07/21.
//

import Foundation
import CoreLocation
import YDB2WModels

public protocol YDB2WServiceAddressDelegate {
  func getAddressFromLocation(
    _ location: CLLocationCoordinate2D,
    onCompletion completion: @escaping (Swift.Result<[YDAddress], YDServiceError>) -> Void
  )
}

public extension YDB2WService {
  func getAddressFromLocation(
    _ location: CLLocationCoordinate2D,
    onCompletion completion: @escaping (Swift.Result<[YDAddress], YDServiceError>) -> Void
  ) {
    let parameters = [
      "latitude":  location.latitude,
      "longitude": location.longitude
    ]

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }

      self.service.request(
        withUrl: self.zipcode,
        withMethod: .get,
        andParameters: parameters
      ) { (response: Swift.Result<[YDAddress], YDServiceError>) in
        completion(response)
      }
    }
  }
}
