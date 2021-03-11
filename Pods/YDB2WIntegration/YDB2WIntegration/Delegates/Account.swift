//
//  Account.swift
//  YDIntegration
//
//  Created by Douglas Hennrich on 27/10/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import Foundation

import YDB2WModels

public protocol YDIntegrationHelperAccountDelegate {
  func getCustomer(completion: ((YDCurrentCustomer?) -> Void)?)
  func getAddress(completion: ((YDAddress?) -> Void)?)
}

public extension YDIntegrationHelperAccountDelegate {
  func getCustomer(completion: ((YDCurrentCustomer?) -> Void)?) {}
  func getAddress(completion: ((YDAddress?) -> Void)?) {}
}
