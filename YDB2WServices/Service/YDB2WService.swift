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
import YDUtilities

public class YDB2WService {
  // MARK: Properties
  let service: YDServiceClientDelegate

  let restQL: String
  let restQLVersion: Int
  let userChat: String
  let products: String
  let store: String
  let zipcode: String
  let spacey: String
  let lasaClient: String
  let youTubeAPI: String
  let chatService: String

  var youTubeKey = ""

  // MARK: Init
  public init() {
    guard let restQLApi = YDIntegrationHelper.shared
            .getFeature(featureName: YDConfigKeys.restQL.rawValue)?.endpoint,

          let restQLVersion = YDIntegrationHelper.shared
            .getFeature(featureName: YDConfigKeys.store.rawValue)?
            .extras?[YDConfigProperty.productsQueryVersion.rawValue] as? Int,

          let userChatApi = YDIntegrationHelper.shared
            .getFeature(featureName: YDConfigKeys.chatService.rawValue)?.endpoint,

          let storeApi = YDIntegrationHelper.shared
            .getFeature(featureName: YDConfigKeys.storeService.rawValue)?.endpoint,

          let productsApi = YDIntegrationHelper.shared
            .getFeature(featureName: YDConfigKeys.productService.rawValue)?.endpoint,

          let zipcodeApi = YDIntegrationHelper.shared
            .getFeature(featureName: YDConfigKeys.addressService.rawValue)?.endpoint,

          let spaceyApi = YDIntegrationHelper.shared
            .getFeature(featureName: YDConfigKeys.spaceyService.rawValue)?.endpoint,

          let lasaApi = YDIntegrationHelper.shared
            .getFeature(featureName: YDConfigKeys.lasaClientService.rawValue)?.endpoint,

          let googleServiceConfig = YDIntegrationHelper.shared
            .getFeature(featureName: YDConfigKeys.googleService.rawValue),
          let googleServiceApi = googleServiceConfig.endpoint,

          let chatService = YDIntegrationHelper.shared
            .getFeature(featureName: YDConfigKeys.chatService.rawValue)?.endpoint
    else {
      fatalError("Não foi possível resgatar todas APIs")
    }

    self.service = YDServiceClient()
    self.restQL = restQLApi
    self.restQLVersion = restQLVersion
    self.userChat = userChatApi
    self.products = productsApi
    self.store = storeApi
    self.zipcode = zipcodeApi
    self.spacey = spaceyApi
    self.lasaClient = lasaApi
    self.youTubeAPI = "\(googleServiceApi)/youtube/v3/videos?part=statistics,liveStreamingDetails"

    if let youTubeKey = googleServiceConfig
    .extras?[YDConfigProperty.youtubeKey.rawValue] as? String {
      self.youTubeKey = youTubeKey
    }

    self.chatService = chatService
  }
}

extension YDB2WService: YDB2WServiceDelegate {
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

    let url = "\(store)/store/geo-types"

    DispatchQueue.global().async { [weak self] in
      self?.service.request(
        withUrl: url,
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

  public func getProductsFromRESQL(
    eans: [String],
    storeId: String?,
    onCompletion completion: @escaping (Swift.Result<YDProductsRESQL, YDServiceError>) -> Void
  ) {
    var parameters: [String: String] = [:]

    if let storeId = storeId {
      parameters["store"] = storeId
    }

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }

      var url = "\(self.restQL)/run-query/app/lasa-and-b2w-product-by-ean/\(self.restQLVersion)?"

      eans.forEach { url += "ean=\($0)&" }

      self.service.requestWithFullResponse(
        withUrl: String(url.dropLast()),
        withMethod: .get,
        withHeaders: nil,
        andParameters: parameters
      ) { (response: DataResponse<Data>?) in
        guard let data = response?.data else {
          completion(
            .failure(
              YDServiceError.init(withMessage: "Nenhum dado retornado")
            )
          )
          return
        }

        do {
          guard let json = try JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments
          ) as? [String: Any] else {
            completion(
              .failure(
                YDServiceError.init(withMessage: "Nenhum dado retornado")
              )
            )
            return
          }

          let restQL = YDProductsRESQL(withJson: json)
          completion(.success(restQL))

        } catch {
          completion(
            .failure(
              YDServiceError.init(error: error)
            )
          )
        }
      }
    }
  }

  public func getProducts(
    ofIds ids: [String],
    onCompletion completion: @escaping (Swift.Result<[YDProductFromIdInterface], YDServiceError>) -> Void
  ) {
    let parameters = [
      "productIds": ids.joined(separator: ",")
    ]

    let url = "\(products)/product_cells_by_ids"

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }
      self.service.requestWithoutCache(
        withUrl: url,
        withMethod: .get,
        andParameters: parameters
      ) { (result: Swift.Result<[Throwable<YDProductFromIdInterface>], YDServiceError>) in
        switch result {
        case .success(let products):
          completion(.success(products.compactMap { try? $0.result.get() }))

        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}
