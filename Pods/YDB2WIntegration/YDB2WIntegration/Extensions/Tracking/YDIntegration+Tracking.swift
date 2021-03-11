//
//  YDIntegration+Tracking.swift
//  YDB2WIntegration
//
//  Created by Douglas Hennrich on 08/12/20.
//

import Foundation

// MARK: Tracking
public extension YDIntegrationHelper {
  func trackEvent(
    withName name: TrackEvents,
    ofType type: TrackType,
    withParameters parameters: [String: Any]? = nil
  ) {
    var payload: [String: Any] = [:]

    payload = payload.merging(name.defaultParameters) { _, new in new }

    if let parameters = parameters {
      payload = payload.merging(parameters) { (_, new) in new }
    }

    // FOR TESTING
//    Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { _ in
//      UIAlertController.showAlert(title: "Evento: \(name.rawValue)", message: "tipo: \(type.rawValue)\npayload: \(payload)")
//    }

    if type == .action {
      trackAdobeAction(actionName: name.rawValue, parameters: payload)
      trackFacebookEvent(eventName: name.rawValue, parameters: payload)
      trackFirebaseEvent(eventName: name.rawValue, parameters: payload)
    } else if type == .state {
      trackAdobeState(stateName: name.rawValue, parameters: payload)
    }
  }
}

extension YDIntegrationHelper {
  func trackAdobeState(stateName: String, parameters: [String: Any]?) {
    trackingDelegate?.trackAdobeState(stateName: stateName, parameters: parameters)
  }

  func trackAdobeAction(actionName: String, parameters: [String: Any]?) {
    trackingDelegate?.trackAdobeAction(actionName: actionName, parameters: parameters)
  }

  func trackFacebookEvent(eventName: String, parameters: [String: Any]?) {
    trackingDelegate?.trackFacebookEvent(eventName: eventName, parameters: parameters)
  }

  func trackFirebaseEvent(eventName: String, parameters: [String: Any]?) {
    trackingDelegate?.trackFirebaseEvent(eventName: eventName, parameters: parameters)
  }
}
