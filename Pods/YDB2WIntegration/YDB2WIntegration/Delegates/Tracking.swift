//
//  TrackingDelegate.swift
//  YDIntegration
//
//  Created by Douglas Hennrich on 27/10/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import Foundation

public protocol YDIntegrationHelperTrackingDelegate {
  func trackAdobeState(stateName: String, parameters: [String: Any]?)
  func trackAdobeAction(actionName: String, parameters: [String: Any]?)
  func trackFacebookEvent(eventName: String, parameters: [String: Any]?)
  func trackFirebaseEvent(eventName: String, parameters: [String: Any]?)
  func trackNewRelicEvent(eventName: String, parameters: [String: Any]?)
  func trackStuartEvent(eventName: String, parameters: [String: Any]?)
}
