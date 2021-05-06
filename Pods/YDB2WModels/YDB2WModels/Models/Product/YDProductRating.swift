//
//  YDProductRating.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 25/03/21.
//

import Foundation

public struct YDProductRating: Codable {
  public let average: Double
  public let recommendations: Int
  public let reviews: Int

  public init(
    average: Double,
    recommendations: Int,
    reviews: Int
  ) {
    self.average = average
    self.recommendations = recommendations
    self.reviews = reviews
  }
}
