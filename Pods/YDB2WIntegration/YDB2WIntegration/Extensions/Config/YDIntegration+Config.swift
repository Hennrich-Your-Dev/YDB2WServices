//
//  YDIntegration+Config.swift
//  YDB2WIntegration
//
//  Created by Douglas Hennrich on 08/12/20.
//

import Foundation

// MARK: Config
extension YDIntegrationHelper {
  public func getFeature(featureName: String) -> YDConfigFeature? {
    return configDelegate?.getFeature(featureName: featureName)
  }
}
