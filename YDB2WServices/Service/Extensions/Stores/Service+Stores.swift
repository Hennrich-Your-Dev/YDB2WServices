//
//  Service+Stores.swift
//  YDB2WServices
//
//  Created by Douglas Hennrich on 15/07/21.
//

import Foundation
import CoreLocation
import YDB2WModels

public protocol YDB2WServiceStoresDelegate {
  func getNearstLasa(
    with location: CLLocationCoordinate2D,
    onCompletion completion: @escaping (Swift.Result<YDStores, YDServiceError>) -> Void
  )
}

public extension YDB2WService {
  func getNearstLasa(
    with location: CLLocationCoordinate2D,
    onCompletion completion: @escaping (Swift.Result<YDStores, YDServiceError>) -> Void
  ) {
    let parameters: [String: Any] = [
      "latitude": location.latitude,
      "longitude": location.longitude,
      "type": "PICK_UP_IN_STORE",
      "radius": storeMaxRadius
    ]

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }

      self.service.request(
        withUrl: self.store,
        withMethod: .get,
        andParameters: parameters
      ) { (response: Swift.Result<YDStores, YDServiceError>) in
        switch response {
          case .success(let list):
            list.stores.sort(by: { $0.distance ?? 10000 < $1.distance ?? 10000 })
            completion(.success(list))

          case .failure(let error):
            completion(.failure(error))
        }
      }
    }
  }
}
