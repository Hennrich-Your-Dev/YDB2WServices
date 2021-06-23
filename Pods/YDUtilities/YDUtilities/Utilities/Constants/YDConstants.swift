//
//  YDConstants.swift
//  YDUtilities
//
//  Created by Douglas Hennrich on 16/06/21.
//

import UIKit

public enum YDConstants {
  // Notifications
  public struct Notification {
    public static let SpaceyNPSChangeValue = NSNotification.Name("YDSpaceyNPSChangeValue")
    public static let SpaceyErrorTrigger = NSNotification.Name("SpaceyErrorTrigger")
  }

  // UserDefaults
  public struct UserDefaults {
    public static let savedNextLives = "YDSavedNextLives"
  }
}
