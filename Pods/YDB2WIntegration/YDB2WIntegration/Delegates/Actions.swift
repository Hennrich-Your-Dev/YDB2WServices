//
//  Actions.swift
//  YDIntegration
//
//  Created by Douglas Hennrich on 27/10/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import Foundation

import YDB2WModels

public protocol YDIntegrationHelperActionDelegate {
  func activateDiscount(offerId: String, completion: ((Bool) -> Void)?)
  func addProductToCart(parameters: [String: Any]?)
  func makeLogin(completion: ((YDCurrentCustomer?) -> Void)?)
  func getNPSList(completion: (([YDMNPSListConfig]) -> Void)?)
}
