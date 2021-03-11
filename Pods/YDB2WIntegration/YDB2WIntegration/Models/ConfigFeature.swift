//
//  YDIntegrationConfigFeature.swift
//  YDIntegration
//
//  Created by Douglas Hennrich on 27/10/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import Foundation

public struct YDConfigFeature {
  public init(name: String, extras: [String : Any]?, endpoint: String?) {
    self.name = name
    self.extras = extras
    self.endpoint = endpoint
  }

  public let name: String
  public let extras: [String: Any]?
  public let endpoint: String?
}
