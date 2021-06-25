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

public protocol YDB2WServiceDelegate:
  YDB2WServiceLiveDelegate,
  YDB2WServiceChatDelegate,
  YDB2WServiceLasaClientDelegate,
  YDB2WServiceSpaceyDelegate {
  //
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

  func getProduct(
    ofIds ids: (id: String, sellerId: String),
    onCompletion completion: @escaping (Swift.Result<YDProductFromIdInterface, YDServiceError>) -> Void
  )
}
