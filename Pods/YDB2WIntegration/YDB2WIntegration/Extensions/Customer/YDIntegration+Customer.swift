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
    accountDelegate?.getCustomer { [weak self] user in
      guard let self = self else { return }
      self.currentUser = user
      completion?(user)
    }
  }
}

// MARK: Make login
public extension YDIntegrationHelper {
  func makeLogin(completion: ((YDCurrentCustomer?) -> Void)?) {
    actionDelegate?.makeLogin { [weak self] user in
      guard let self = self else { return }
      self.currentUser = user
      completion?(user)
    }
  }
}
