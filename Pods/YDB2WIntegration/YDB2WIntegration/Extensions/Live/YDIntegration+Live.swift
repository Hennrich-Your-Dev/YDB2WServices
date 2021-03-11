//
//  YDIntegration+Live.swift
//  YDB2WIntegration
//
//  Created by Douglas Hennrich on 08/12/20.
//

import UIKit

// MARK: Open live module
public extension YDIntegrationHelper {
  func openLive(navigationController: UINavigationController) {
    presentationDelegate?.presentLive(navigationController: navigationController)
  }
}

// MARK: Add to cart
public extension YDIntegrationHelper {
  func addProductToCart(parameters: [String: Any]?) {
    actionDelegate?.addProductToCart(parameters: parameters)
  }
}
