//
//  UIViewControllerExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 22/10/20.
//

import UIKit

public extension UIViewController {

  class var identifier: String {
    return String(describing: self)
  }

  class func initializeFromStoryboard() -> Self? {
    let bundle = Bundle.init(for: Self.self)
    let storyboard = UIStoryboard(
      name: NSStringFromClass(Self.self)
        .components(separatedBy: ".")
        .last!,
      bundle: bundle
    )

    return storyboard.instantiateViewController(withIdentifier: self.identifier) as? Self
  }

  func topMostViewController() -> UIViewController? {
    if self.presentedViewController == nil {
      return self
    }

    if let navigation = self.presentedViewController as? UINavigationController {
      return navigation.visibleViewController?.topMostViewController()
    }

    if let tab = self.presentedViewController as? UITabBarController {
      if let selectedTab = tab.selectedViewController {
        return selectedTab.topMostViewController()
      }
      return tab.topMostViewController()
    }

    return self.presentedViewController?.topMostViewController()
  }
}
