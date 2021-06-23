//
//  YDIntegration+StoreMode.swift
//  YDB2WIntegration
//
//  Created by Douglas Hennrich on 08/12/20.
//

import Foundation

// MARK: Open store module
public extension YDIntegrationHelper {
  func openStoreMode(deeplink: String?) {
    presentationDelegate?.presentStoreMode(deeplink: deeplink)
  }
}

// MARK: On product discount
public extension YDIntegrationHelper {
  func activateDiscount(offerId: String, completion: ((Bool) -> Void)?) {
    actionDelegate?.activateDiscount(offerId: offerId, completion: completion)
  }
}
