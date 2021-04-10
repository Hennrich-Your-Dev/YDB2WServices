//
//  DoubleExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 05/04/21.
//

import UIKit

public extension Double {
  var formatedPrice: String? {
    let formatter = NumberFormatter()
    formatter.alwaysShowsDecimalSeparator = true
    formatter.locale = Locale(identifier: "pt_BR")
    formatter.numberStyle = .currency

    return formatter.string(for: self)
  }
}
