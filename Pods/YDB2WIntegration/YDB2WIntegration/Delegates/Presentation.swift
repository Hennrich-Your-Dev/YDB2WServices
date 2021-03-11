//
//  Presentation.swift
//  YDIntegration
//
//  Created by Douglas Hennrich on 27/10/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import UIKit

import YDB2WModels

public protocol YDIntegrationHelperPresentationDelegate {
  func presentScanner()
  func presentStoreMode()
  func presentLive(navigationController: UINavigationController)
  func presentSelectAddress(completion: ((YDAddress?) -> Void)?)
}

public extension YDIntegrationHelperPresentationDelegate {
  func presentScanner() {}
  func presentStoreMode() {}
  func presentLive(navigationController: UINavigationController) {}
  func presentSelectAddress(completion: ((YDAddress?) -> Void)?) {}
}
