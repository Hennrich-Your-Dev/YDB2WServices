//
//  YDB2WServiceDelegate.swift
//  YDB2WServices
//
//  Created by Douglas Hennrich on 11/03/21.
//

import Foundation
import CoreLocation

import Alamofire
import YDB2WModels

public protocol YDB2WServiceDelegate: AnyObject {
  func getNearstLasa(
    with location: CLLocationCoordinate2D,
    onCompletion completion: @escaping (Swift.Result<YDStores, YDServiceError>) -> Void
  )

  func getAddressFromLocation(
    _ location: CLLocationCoordinate2D,
    onCompletion completion: @escaping (Swift.Result<[YDAddress], YDServiceError>) -> Void
  )

  func getProductsFromRESQL(
    eans: [String],
    storeId: String?,
    onCompletion completion: @escaping (Swift.Result<YDProductsRESQL, YDServiceError>) -> Void
  )

  // Live
  func getYouTubeDetails(
    withVideoId videoId: String,
    onCompletion: @escaping (Swift.Result<YDYouTubeDetails, YDServiceError>) -> Void
  )

  // Offline Orders
  func offlineOrdersGetOrders(
    userToken token: String,
    page: Int,
    limit: Int,
    onCompletion completion: @escaping (Swift.Result<YDOfflineOrdersOrdersList, YDServiceError>) -> Void
  )

  // Spacey
  func getSpacey(
    spaceyId: String,
    onCompletion completion: @escaping (Swift.Result<YDSpacey, YDServiceError>) -> Void
  )

  func getNextLives(
    spaceyId: String,
    onCompletion completion: @escaping (DataResponse<Data>?) -> Void
  )
  
  // Lasa Client
  func getLasaClientLogin(
    user: YDCurrentCustomer,
    onCompletion completion: @escaping (Swift.Result<YDLasaClientLogin, YDServiceError>) -> Void
  )

  func getLasaClientInfo(
    with user: YDLasaClientLogin,
    onCompletion completion: @escaping (Swift.Result<YDLasaClientInfo, YDServiceError>) -> Void
  )

  func updateLasaClientInfo(
    user: YDLasaClientLogin,
    parameters: [String: Any],
    onCompletion completion: @escaping (Swift.Result<Void, YDServiceError>) -> Void
  )

  func getLasaClientHistoric(
    with user: YDLasaClientLogin,
    onCompletion completion: @escaping (Swift.Result<[YDLasaClientHistoricData], YDServiceError>) -> Void
  )
}
