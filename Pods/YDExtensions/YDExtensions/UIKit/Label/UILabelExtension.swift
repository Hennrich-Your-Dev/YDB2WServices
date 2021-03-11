//
//  UILabelExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 14/12/20.
//

import UIKit

public extension UILabel {
  func addCharacterSpacing(spacing: Double = -0.2) {
    if let labelText = text,
      !labelText.isEmpty {
      let attributedString = NSMutableAttributedString(string: labelText)

      attributedString.addAttribute(
        NSAttributedString.Key.kern,
        value: spacing,
        range: NSRange(location: 0, length: attributedString.length - 1)
      )

      attributedText = attributedString
    }
  }
}
