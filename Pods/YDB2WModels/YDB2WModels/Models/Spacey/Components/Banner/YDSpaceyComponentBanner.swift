//
//  YDSpaceyComponentBanner.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 14/04/21.
//

import Foundation

public class YDSpaceyComponentBanner: Decodable {
  // Properties
  public let id: String
  public let small: String?
  public let medium: String?
  public let big: String?
  public let large: String?
  public let extralarge: String?
  public let defaultSize: YDSpaceyComponentBannerDefaultImage
  public let deepLink: String?
  public let componentType: YDSpaceyComponentsTypes.Types = .banner

  public var currentImageHeight: CGFloat?

  // Computed variables
  public var bannerImage: String? {
    var image: String? = nil

    switch defaultSize {
    case .small:
      image = small

    case .medium:
      image = medium

    case .big:
      image = big

    case .large:
      image = large

    case .extralarge:
      image = extralarge
    }

    if image?.isEmpty ?? true {
      let images = [extralarge, large, big, medium, small].compactMap { $0 }
      return images.first(where: { !$0.isEmpty })
    }

    return image
  }

  // Coding Keys
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case small
    case medium
    case big
    case large
    case extralarge
    case defaultSize
    case deepLink = "linkUrl"
  }

  // Init
  public init(
    id: String,
    medium: String,
    defaultSize: YDSpaceyComponentBannerDefaultImage
  ) {
    self.id = id
    self.medium = medium
    self.defaultSize = defaultSize

    self.small = nil
    self.big = nil
    self.large = nil
    self.extralarge = nil
    self.deepLink = nil
  }
}

public enum YDSpaceyComponentBannerDefaultImage: String, Decodable {
  case small
  case medium
  case big
  case large
  case extralarge
}
