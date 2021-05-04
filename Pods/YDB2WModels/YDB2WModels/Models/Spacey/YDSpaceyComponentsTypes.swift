//
//  YDSpaceyComponentsTypes.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 14/04/21.
//

import Foundation

public enum YDSpaceyComponentsTypes: Decodable {
  case player(YDSpaceyComponentPlayer)
  case product(YDSpaceyComponentProduct)
  case banner(YDSpaceyComponentBanner)
  case nextLive(YDSpaceyComponentNextLive)

  enum CodingKeys: String, CodingKey {
    case type
  }

  // Components Types
  enum `Types`: String, Decodable {
    case player = "zion-video"
    case product = "zion-product"
    case banner = "zion-image"
    case nextLive = "live-schedule-item"
  }

  // MARK: Init
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let type = try container.decode(Types.self, forKey: .type)

    switch type {
      case .player:
        let playerContainer = try decoder.singleValueContainer()
        self = .player(try playerContainer.decode(YDSpaceyComponentPlayer.self))

      case .product:
        let productContainer = try decoder.singleValueContainer()
        self = .product(try productContainer.decode(YDSpaceyComponentProduct.self))

      case .banner:
        let bannerContainer = try decoder.singleValueContainer()
        self = .banner(try bannerContainer.decode(YDSpaceyComponentBanner.self))

      case .nextLive:
        let nextLiveContainer = try decoder.singleValueContainer()
        self = .nextLive(try nextLiveContainer.decode(YDSpaceyComponentNextLive.self))
    }
  }

  public init(player: YDSpaceyComponentPlayer) {
    self = .player(player)
  }

  public init(product: YDSpaceyComponentProduct) {
    self = .product(product)
  }

  public init(banner: YDSpaceyComponentBanner) {
    self = .banner(banner)
  }

  public init(nextLive: YDSpaceyComponentNextLive) {
    self = .nextLive(nextLive)
  }

  // MARK: Actions
  public func get() -> Any {
    switch self {
      case .player(let player):
        return player

      case .product(let product):
        return product

      case .banner(let banner):
        return banner

      case .nextLive(let nextLive):
        return nextLive
    }
  }
}
