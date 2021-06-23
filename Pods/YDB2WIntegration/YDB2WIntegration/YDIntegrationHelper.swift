//
//  YDIntegrationHelper.swift
//  YDB2WIntegration
//
//  Created by Douglas Hennrich on 08/12/20.
//

import Foundation
import CoreLocation

import YDB2WModels

public class YDIntegrationHelper {
  // MARK: Properties
  public static let shared = YDIntegrationHelper()
  public var currentAddres: YDAddress?
  public var currentUser: YDCurrentCustomer?

  // MARK: Delegates
  public var configDelegate: YDIntegrationHelperConfigDelegate?
  public var trackingDelegate: YDIntegrationHelperTrackingDelegate?
  public var presentationDelegate: YDIntegrationHelperPresentationDelegate?
  public var actionDelegate: YDIntegrationHelperActionDelegate?
  public var accountDelegate: YDIntegrationHelperAccountDelegate?

  // MARK: Init
  private init() {}
}
