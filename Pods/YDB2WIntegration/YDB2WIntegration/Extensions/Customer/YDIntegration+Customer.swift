//
//  YDIntegration+Customer.swift
//  YDB2WIntegration
//
//  Created by Douglas Hennrich on 08/12/20.
//

import Foundation

import YDB2WModels

// MARK: Get Customer
public extension YDIntegrationHelper {
  func getCustomer(completion: ((YDCurrentCustomer?) -> Void)?) {
    accountDelegate?.getCustomer(completion: completion)
  }
}

// MARK: Make login
public extension YDIntegrationHelper {
  func makeLogin(completion: ((YDCurrentCustomer?) -> Void)?) {
    actionDelegate?.makeLogin(completion: completion)
  }
}
