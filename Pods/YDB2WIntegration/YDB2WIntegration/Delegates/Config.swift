//
//  ConfigDelegate.swift
//  YDIntegration
//
//  Created by Douglas Hennrich on 27/10/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import Foundation

public protocol YDIntegrationHelperConfigDelegate {
  func getFeature(featureName: String) -> YDConfigFeature?
}
