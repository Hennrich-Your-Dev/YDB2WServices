//
//  YDB2WServiceDelegate.swift
//  YDB2WServices
//
//  Created by Douglas Hennrich on 11/03/21.
//

import Foundation
import CoreLocation

import YDB2WIntegration
import YDB2WModels

public protocol YDB2WServiceDelegate: AnyObject {
  func offlineOrdersGetOrders(
    userToken token: String,
    page: Int,
    limit: Int,
    onCompletion completion: @escaping (Result<YDOfflineOrdersOrdersList, YDServiceError>) -> Void
  )

  func getNearstLasa(
    with location: CLLocationCoordinate2D,
    onCompletion completion: @escaping (Result<YDStores, YDServiceError>) -> Void
  )

  func getAddressFromLocation(
    _ location: CLLocationCoordinate2D,
    onCompletion completion: @escaping (Result<[YDAddress], YDServiceError>) -> Void
  )

  func getProductsFromRESQL(
    eans: [String],
    storeId: String?,
    onCompletion completion: @escaping (Result<YDProductsRESQL, YDServiceError>) -> Void
  )

  func getSpacey(
    spaceyId: String,
    onCompletion completion: @escaping (Result<YDSpacey, YDServiceError>) -> Void
  )
  
  // Lasa Client
  func getLasaClientLogin(
    user: YDCurrentCustomer,
    onCompletion completion: @escaping (Result<YDLasaClientLogin, YDServiceError>) -> Void
  )

  func getLasaClientInfo(
    with user: YDLasaClientLogin,
    onCompletion completion: @escaping (Swift.Result<YDLasaClientInfo, YDServiceError>) -> Void
  )

  func updateLasaClientInfo(
    user: YDLasaClientLogin,
    parameters: [String: Any],
    onCompletion completion: @escaping (Result<Void, YDServiceError>) -> Void
  )

  func getLasaClientHistoric(
    with user: YDLasaClientLogin,
    onCompletion completion: @escaping (Result<[YDLasaClientHistoricData], YDServiceError>) -> Void
  )
}
