//
//  YDB2WServiceDelegate.swift
//  YDB2WServices
//
//  Created by Douglas Hennrich on 11/03/21.
//

import Foundation
import CoreLocation

import YDB2WModels

public protocol YDB2WServiceDelegate: AnyObject {
  func offlineOrdersGetOrders(
    userToken token: String,
    page: Int,
    limit: Int,
    onCompletion completion: @escaping (Swift.Result<YDOfflineOrdersOrdersList, YDServiceError>) -> Void
  )

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

  func getSpacey(
    spaceyId: String,
    onCompletion completion: @escaping (Swift.Result<YDSpacey, YDServiceError>) -> Void
  )
}
