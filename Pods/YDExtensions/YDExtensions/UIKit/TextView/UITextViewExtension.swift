//
//  UITextViewExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 25/11/20.
//

import UIKit

public extension UITextView {
  func addButtonNext(target: Any?, buttonTitle: String = "Continuar", action: Selector?) {
    let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 56))

    toolBar.barStyle = UIBarStyle.default
    toolBar.layer.borderColor = UIColor.clear.cgColor
    toolBar.clipsToBounds = true
    toolBar.isTranslucent = true

    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)

    let next: UIBarButtonItem = UIBarButtonItem(title: buttonTitle,
                                                style: .done,
                                                target: target,
                                                action: action)
    next.tintColor = UIColor.Zeplin.redBranding

    toolBar.items = [ flexSpace, flexSpace, next ]
    toolBar.sizeToFit()

    self.inputAccessoryView = toolBar
  }
}
