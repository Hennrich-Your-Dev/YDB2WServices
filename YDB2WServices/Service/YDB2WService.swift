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
  private let helper = YDIntegrationHelper.shared
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
  let invoiceService: String

  var youTubeKey = ""
  var storeMaxRadius: Double = 3500

  // MARK: Init
  public init() {
    guard let restQLApi = helper.getFeature(featureName: YDConfigKeys.restQL.rawValue)?.endpoint,
          let restQLVersion = helper.getFeature(featureName: YDConfigKeys.store.rawValue)?
            .extras?[YDConfigProperty.productsQueryVersion.rawValue] as? Int,

          let userChatApi = helper
            .getFeature(featureName: YDConfigKeys.chatService.rawValue)?.endpoint,

          let storeApi = helper
            .getFeature(featureName: YDConfigKeys.storeService.rawValue)?.endpoint,

          let productsApi = helper
            .getFeature(featureName: YDConfigKeys.productService.rawValue)?.endpoint,

          let zipcodeApi = helper
            .getFeature(featureName: YDConfigKeys.addressService.rawValue)?.endpoint,

          let spaceyApi = helper
            .getFeature(featureName: YDConfigKeys.spaceyService.rawValue)?.endpoint,

          let lasaApi = helper
            .getFeature(featureName: YDConfigKeys.lasaClientService.rawValue)?.endpoint,

          let googleServiceConfig = helper
            .getFeature(featureName: YDConfigKeys.googleService.rawValue),
          let googleServiceApi = googleServiceConfig.endpoint,

          let chatService = helper.getFeature(featureName: YDConfigKeys.chatService.rawValue)?
            .endpoint,

          let invoiceService = helper.getFeature(featureName: YDConfigKeys.invoiceService.rawValue)?
            .endpoint
    else {
      fatalError("Não foi possível resgatar todas APIs")
    }

    self.service = YDServiceClient()
    self.restQL = restQLApi
    self.restQLVersion = restQLVersion
    self.userChat = userChatApi
    self.products = productsApi
    self.store = "\(storeApi)/store/geo-types"
    self.zipcode = zipcodeApi
    self.spacey = spaceyApi
    self.lasaClient = lasaApi
    self.youTubeAPI = "\(googleServiceApi)/youtube/v3/videos?part=statistics,liveStreamingDetails"
    self.chatService = chatService
    self.invoiceService = invoiceService

    if let youTubeKey = googleServiceConfig
    .extras?[YDConfigProperty.youtubeKey.rawValue] as? String {
      self.youTubeKey = youTubeKey
    }

    if let radiusFromConfig = helper
        .getFeature(featureName: YDConfigKeys.store.rawValue)?
        .extras?[YDConfigProperty.maxStoreRange.rawValue] as? Double {
      self.storeMaxRadius = radiusFromConfig
    }
  }
}

extension YDB2WService: YDB2WServiceDelegate {}
