//
//  UIWindowExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 05/11/20.
//

import UIKit

public extension UIWindow {
  static var keyWindow: UIWindow? {
    if #available(iOS 13, *) {
      return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    } else {
      return UIApplication.shared.keyWindow
    }
  }
}
