//
//  CGFloatExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 14/02/21.
//

import UIKit

public extension CGFloat {
  static var random: CGFloat {
    return CGFloat(arc4random()) / CGFloat(UInt32.max)
  }
}
