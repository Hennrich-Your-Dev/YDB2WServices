//
//  UIAlertControllerExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 22/10/20.
//
import UIKit

public extension UIAlertController {

  func presentInOwnWindow(animated: Bool, completion: (() -> Void)?) {
    let alertWindow = UIWindow(frame: UIScreen.main.bounds)
    alertWindow.rootViewController = UIViewController()
    alertWindow.windowLevel = UIWindow.Level.alert + 1
    alertWindow.makeKeyAndVisible()
    alertWindow.rootViewController?
      .present(self,
               animated: animated,
               completion: completion
      )
  }

  class func showAlert(
    title: String = "Alerta",
    message: String
  ) {

    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

    alertController.addAction(
      UIAlertAction(
        title: "OK",
        style: UIAlertAction.Style.cancel,
        handler: nil
      )
    )

    alertController.presentInOwnWindow(animated: true, completion: nil)
  }
}

public extension UIAlertController {
  //Set background color of UIAlertController
  func setBackgroundColor(color: UIColor) {
    if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
      contentView.backgroundColor = color
    }
  }

  //Set title font and title color
  func setTitle(font: UIFont?, color: UIColor?) {
    guard let title = self.title else { return }
    let attributeString = NSMutableAttributedString(string: title)
    if let titleFont = font {
      attributeString.addAttributes(
        [NSAttributedString.Key.font : titleFont],
        range: NSRange(location: 0, length: title.utf16.count)
      )
    }

    if let titleColor = color {
      attributeString.addAttributes(
        [NSAttributedString.Key.foregroundColor : titleColor],
        range: NSRange(location: 0, length: title.utf16.count)
      )
    }
    self.setValue(attributeString, forKey: "attributedTitle")
  }

  //Set message font and message color
  func setMessage(font: UIFont?, color: UIColor?) {
    guard let message = self.message else { return }
    let attributeString = NSMutableAttributedString(string: message)
    if let messageFont = font {
      attributeString.addAttributes(
        [NSAttributedString.Key.font : messageFont],
        range: NSRange(location: 0, length: message.utf16.count)
      )
    }

    if let messageColorColor = color {
      attributeString.addAttributes(
        [NSAttributedString.Key.foregroundColor : messageColorColor],
        range: NSRange(location: 0, length: message.utf16.count)
      )
    }
    self.setValue(attributeString, forKey: "attributedMessage")
  }

  //Set tint color of UIAlertController
  func setTint(color: UIColor) {
    self.view.tintColor = color
  }
}
