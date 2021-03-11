//
//  CALayerExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 22/10/20.
//

import UIKit

public extension CALayer {

  func applyShadow(
    color: UIColor = .black,
    alpha: Float = 0.1,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0
  ) {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0

    if spread == 0 {
      shadowPath = nil
    } else {
      let dxSpread = -spread
      let rect = bounds.insetBy(dx: dxSpread, dy: dxSpread)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
