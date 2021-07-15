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
    // Spacey
    public static let SpaceyNPSChangeValue = NSNotification.Name("YDSpaceyNPSChangeValue")
    public static let SpaceyErrorTrigger = NSNotification.Name("YDSpaceyErrorTrigger")
    public static let SpaceyProductAddToCard = NSNotification.Name("YDSpaceyProductAddToCard")

    // Components
    public static let ComponentsCleanUpReply = NSNotification.Name("YDComponentsCleanUpReply")
    public static let ComponentsMessageFieldResign = NSNotification.Name("YDMessageFieldResignFirstResponder")

    // Miscellaneous
    public static let Deinit = NSNotification.Name("YDDeinit")
  }

  // UserDefaults
  public struct UserDefaults {
    public static let savedNextLives = "YDSavedNextLives"
    public static let savedLiveNPS = "YDSavedLiveNPS"
  }
}
