//
//  YDSpaceyComponentsTypes.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 14/04/21.
//

import Foundation

public enum YDSpaceyComponentsTypes: Decodable {
  case banner(YDSpaceyComponentBanner)
  case bannerCarrousel(YDSpaceyComponentCarrouselBanner)
  case grid(YDSpaceyComponentGrid)
  case liveNPS(YDSpaceyComponentLiveNPS)
  case liveNPSCard(YDSpaceyComponentLiveNPSCard)
  case liveNPSCardQuestion(YDSpaceyComponentLiveNPSCardQuestion)
  case nextLiveParent(YDSpaceyCommonComponent)
  case nextLive(YDSpaceyComponentNextLive)
  case player(YDSpaceyComponentPlayer)
  case product(YDSpaceyComponentProduct)
  case productCarrousel(YDSpaceyComponentCarrouselProduct)
  case termsOfUse(YDSpaceyComponentTermsOfUse)
  case title(YDSpaceyComponentTitle)
  case nps(YDSpaceyComponentNPS)
  case npsEditText(YDSpaceyComponentNPSQuestion)
  case npsQuestion(YDSpaceyComponentNPSQuestion)

  case custom(YDSpaceyCustomComponentDelegate)

  enum CodingKeys: String, CodingKey {
    case type
  }

  public var componentType: `Types` {
    switch self {
      case .banner:
        return .banner

      case .bannerCarrousel:
        return .bannerCarrousel

      case .grid:
        return .grid

      case .liveNPS:
        return .liveNPS

      case .liveNPSCard:
        return .liveNPSCard

      case .liveNPSCardQuestion:
        return .liveNPSCardQuestion

      case .nextLiveParent:
        return .nextLiveParent

      case .nextLive:
        return .nextLive

      case .player:
        return .player

      case .product:
        return .product

      case .productCarrousel:
        return .productCarrousel

      case .termsOfUse:
        return .termsOfUse

      case .title:
        return .title

      case .nps:
        return .nps

      case .npsQuestion:
        return .npsQuestion

      case .npsEditText:
        return .npsEditText

      case .custom:
        return .custom
    }
  }

  // Components Types
  public enum `Types`: String, Decodable {
    case banner = "zion-image"
    case bannerCarrousel = "zion-image-carousel"
    case grid = "zion-grid"
    case liveNPS = "live-nps"
    case liveNPSCard = "live-nps-card"
    case liveNPSCardQuestion = "live-nps-card-question"
    case nextLiveParent = "live-schedule"
    case nextLive = "live-schedule-item"
    case player = "zion-video"
    case product = "zion-product"
    case productCarrousel = "live-carousel"
    case termsOfUse = "zion-rich-text"
    case title = "zion-title"
    case nps = "nps-card"
    case npsEditText = "edit-text"
    case npsQuestion = "question"
    case custom = "custom-component"
  }

  // MARK: Init
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let type = try container.decode(Types.self, forKey: .type)
    let singleValueContainer = try decoder.singleValueContainer()

    switch type {
      case .banner:
        self = .banner(try singleValueContainer.decode(YDSpaceyComponentBanner.self))

      case .bannerCarrousel:
        self = .bannerCarrousel(
          try singleValueContainer.decode(YDSpaceyComponentCarrouselBanner.self)
        )

      case .grid:
        self = .grid(try singleValueContainer.decode(YDSpaceyComponentGrid.self))

      case .liveNPS:
        self = .liveNPS(try singleValueContainer.decode(YDSpaceyComponentLiveNPS.self))

      case .liveNPSCard:
        self = .liveNPSCard(
          try singleValueContainer.decode(YDSpaceyComponentLiveNPSCard.self)
        )

      case .liveNPSCardQuestion:
        self = .liveNPSCardQuestion(
          try singleValueContainer.decode(YDSpaceyComponentLiveNPSCardQuestion.self)
        )

      case .nextLiveParent:
        self = .nextLiveParent(
          try singleValueContainer.decode(YDSpaceyCommonComponent.self)
        )

      case .nextLive:
        self = .nextLive(try singleValueContainer.decode(YDSpaceyComponentNextLive.self))

      case .player:
        self = .player(try singleValueContainer.decode(YDSpaceyComponentPlayer.self))

      case .product:
        self = .product(try singleValueContainer.decode(YDSpaceyComponentProduct.self))

      case .productCarrousel:
        self = .productCarrousel(
          try singleValueContainer.decode(YDSpaceyComponentCarrouselProduct.self)
        )

      case .termsOfUse:
        self = .termsOfUse(
          try singleValueContainer.decode(YDSpaceyComponentTermsOfUse.self)
        )

      case .title:
        self = .title(try singleValueContainer.decode(YDSpaceyComponentTitle.self))

      case .nps:
        self = .nps(try singleValueContainer.decode(YDSpaceyComponentNPS.self))

      case .npsQuestion:
        self = .npsQuestion(try singleValueContainer.decode(YDSpaceyComponentNPSQuestion.self))

      case .npsEditText:
        self = .npsEditText(try singleValueContainer.decode(YDSpaceyComponentNPSQuestion.self))

      case .custom:
        throw NSError(domain: "", code: 1, userInfo: nil)
    }
  }

  // MARK: Actions
  public func get() -> Any {
    switch self {
      case .banner(let banner):
        return banner

      case .bannerCarrousel(let carrousel):
        return carrousel

      case .grid(let grid):
        return grid

      case .liveNPS(let liveNPS):
        return liveNPS

      case .liveNPSCard(let liveNPSCard):
        return liveNPSCard

      case .liveNPSCardQuestion(let liveNPSCardQuestion):
        return liveNPSCardQuestion

      case .nextLiveParent(let nextLiveParent):
        return nextLiveParent

      case .nextLive(let nextLive):
        return nextLive

      case .player(let player):
        return player

      case .product(let product):
        return product

      case .productCarrousel(let carrousel):
        return carrousel

      case .termsOfUse(let terms):
        return terms

      case .title(let title):
        return title

      case .nps(let nps):
        return nps

      case .npsQuestion(let npsQuestion):
        return npsQuestion

      case .npsEditText(let npsEditText):
        return npsEditText

      case .custom(let custom):
        return custom
    }
  }
}

// To be able to use [].contains(type)
extension YDSpaceyComponentsTypes: Equatable {
  public static func == (lhs: YDSpaceyComponentsTypes, rhs: YDSpaceyComponentsTypes) -> Bool {
    if case .banner = lhs,
       case .banner = rhs {
      return true
    }

    if case .bannerCarrousel = lhs,
       case .bannerCarrousel = rhs {
      return true
    }

    if case .grid = lhs,
       case .grid = rhs {
      return true
    }

    if case .liveNPS = lhs,
       case .liveNPS = rhs {
      return true
    }

    if case .liveNPSCard = lhs,
       case .liveNPSCard = rhs {
      return true
    }

    if case .liveNPSCardQuestion = lhs,
       case .liveNPSCardQuestion = rhs {
      return true
    }

    if case .nextLiveParent = lhs,
       case .nextLiveParent = rhs {
      return true
    }

    if case .nextLive = lhs,
       case .nextLive = rhs {
      return true
    }

    if case .player = lhs,
       case .player = rhs {
      return true
    }

    if case .product = lhs,
       case .product = rhs {
      return true
    }

    if case .productCarrousel = lhs,
       case .productCarrousel = rhs {
      return true
    }

    if case .termsOfUse = lhs,
       case .termsOfUse = rhs {
      return true
    }

    if case .title = lhs,
       case .title = rhs {
      return true
    }

    if case .nps = lhs,
       case .nps = rhs {
      return true
    }

    if case .npsQuestion = lhs,
       case .npsQuestion = rhs {
      return true
    }

    if case .npsEditText = lhs,
       case .npsEditText = rhs {
      return true
    }

    return false
  }
}
