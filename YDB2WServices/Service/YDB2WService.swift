//
//  YDB2WService.swift
//  YDB2WServices
//
//  Created by Douglas Hennrich on 11/03/21.
//

import Foundation
import CoreLocation

import Alamofire

import YDB2WIntegration
import YDB2WModels

public class YDB2WService {
  // MARK: Properties
  let service: YDServiceClientDelegate

  let restQL: String
  let userChat: String
  let catalog: String
  let store: String
  let zipcode: String
  let spacey: String
  let lasaClient: String

  // MARK: Init
  public init() {
    guard let restQLApi = YDIntegrationHelper.shared
            .getFeature(featureName: YDConfigKeys.restQL.rawValue)?.endpoint,
          let userChatApi = YDIntegrationHelper.shared
            .getFeature(featureName: YDConfigKeys.chatService.rawValue)?.endpoint,
          let storeApi = YDIntegrationHelper.shared
            .getFeature(featureName: YDConfigKeys.storeService.rawValue)?.endpoint,
          let catalogApi = YDIntegrationHelper.shared
            .getFeature(featureName: YDConfigKeys.productService.rawValue)?.endpoint,
          let zipcodeApi = YDIntegrationHelper.shared
            .getFeature(featureName: YDConfigKeys.addressService.rawValue)?.endpoint,
          let spaceyApi = YDIntegrationHelper.shared
            .getFeature(featureName: YDConfigKeys.spaceyService.rawValue)?.endpoint,
          let lasaApi = YDIntegrationHelper.shared
            .getFeature(featureName: YDConfigKeys.lasaClientService.rawValue)?.endpoint
    else {
      fatalError("Não foi possível resgatar todas APIs")
    }

    self.service = YDServiceClient()
    self.restQL = restQLApi
    self.userChat = userChatApi
    self.catalog = catalogApi
    self.store = storeApi
    self.zipcode = zipcodeApi
    self.spacey = spaceyApi
    self.lasaClient = lasaApi
  }
}

extension YDB2WService: YDB2WServiceDelegate {
  public func offlineOrdersGetOrders(
    userToken token: String,
    page: Int,
    limit: Int,
    onCompletion completion: @escaping (Swift.Result<YDOfflineOrdersOrdersList, YDServiceError>) -> Void
  ) {
    let url = "\(lasaClient)/portalcliente/cliente/cupons/lista"
    let headers = [
      "Authorization": "Bearer \(token)",
      "Ocp-Apim-Subscription-Key": "953582bd88f84bdb9b3ad66d04eaf728"
    ]
    let parameters = [
      "page_number": page,
      "limite_page": limit
    ]

    DispatchQueue.global().async { [weak self] in
      self?.service.request(
        withUrl: url,
        withMethod: .get,
        withHeaders: headers,
        andParameters: parameters
      ) { (response: Swift.Result<YDOfflineOrdersOrdersList, YDServiceError>) in
        completion(response)
      }
    }
  }

  public func getNearstLasa(
    with location: CLLocationCoordinate2D,
    onCompletion completion: @escaping (Swift.Result<YDStores, YDServiceError>) -> Void
  ) {
    var radius: Double = 35000

    if let radiusFromConfig = YDIntegrationHelper.shared
        .getFeature(featureName: YDConfigKeys.store.rawValue)?
        .extras?[YDConfigProperty.maxStoreRange.rawValue] as? Double {
      radius = radiusFromConfig
    }

    let parameters: [String: Any] = [
      "latitude": location.latitude,
      "longitude": location.longitude,
      "type": "PICK_UP_IN_STORE",
      "radius": radius
    ]

    let url = "\(store)/store"

    DispatchQueue.global().async { [weak self] in
      self?.service.request(
        withUrl: url,
        withMethod: .get,
        andParameters: parameters
      ) { (response: Swift.Result<YDStores, YDServiceError>) in
        completion(response)
      }
    }
  }

  public func getAddressFromLocation(
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
