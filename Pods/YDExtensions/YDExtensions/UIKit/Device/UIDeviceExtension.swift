//
//  UIDeviceExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 23/10/20.
//

import UIKit

public extension UIDevice {

  static var hasNotch: Bool {
    if #available(iOS 11.0, *) {
      return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0 > 0
    }
    return false
  }

  static let iPhone5 = UIScreen.main.nativeBounds.height == 1136

  static let iPhone678 = UIScreen.main.nativeBounds.height == 1334

  static let iPhonePlus = UIScreen.main.nativeBounds.height == 2208
  
}
