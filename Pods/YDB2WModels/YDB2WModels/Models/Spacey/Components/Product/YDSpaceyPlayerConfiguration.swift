//
//  YDSpaceyPlayerConfiguration.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 14/04/21.
//

import Foundation

import YDExtensions

public class YDSpaceyPlayerConfiguration {
  // MARK: Properties
  public let width: CGFloat
  public let height: CGFloat
  public let backgroundColor: UIColor
  public let radius: CGFloat
  public let product: YDSpaceyProduct

  // MARK: Init
  public init(
    withWidth width: CGFloat = 300,
    withHeight height: CGFloat = 203,
    withBackgroundColor backgroundColor: UIColor = UIColor.Zeplin.white,
    withRadius radius: CGFloat = 6,
    withProduct product: YDSpaceyProduct
  ) {
    self.width = width
    self.height = height
    self.backgroundColor = backgroundColor
    self.radius = radius
    self.product = product
  }
}
