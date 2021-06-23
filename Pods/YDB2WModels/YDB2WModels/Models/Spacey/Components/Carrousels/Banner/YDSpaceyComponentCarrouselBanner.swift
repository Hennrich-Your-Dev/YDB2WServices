//
//  YDSpaceyComponentCarrouselBanner.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 10/05/21.
//

import UIKit

public class YDSpaceyComponentCarrouselBanner: YDSpaceyComponentDelegate {
  // MARK: Properties
  public var id: String?
  public var children: [YDSpaceyComponentsTypes]
  public var type: YDSpaceyComponentsTypes.Types
  public var showTitle: Bool
  public var title: String?
  public var itemsToShowOnScreen: Double

  public var currentRectList: CGFloat?

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case children
    case type
    case showTitle = "showTitles"
    case title
    case itemsToShowOnScreen = "itemsToShowMobile"
  }

  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try? container.decode(String.self, forKey: .id)
    type = try container.decode(YDSpaceyComponentsTypes.Types.self, forKey: .type)

    let throwables = try? container.decode(
      [Throwable<YDSpaceyComponentsTypes>].self,
      forKey: .children
    )
    children = throwables?.compactMap { try? $0.result.get() } ?? []

    if let showTitleDecoded = try? container
        .decode(ShowTitleEnum.self, forKey: .showTitle) {
      showTitle = showTitleDecoded == .show ? true : false
    } else {
      showTitle = false
    }

    title = try? container.decode(String.self, forKey: .title)

    if let itemsToShowDecoded = try? container.decode(String.self, forKey: .itemsToShowOnScreen) {
      itemsToShowOnScreen = Double(itemsToShowDecoded) ?? 1

    } else {
      itemsToShowOnScreen = 1
    }
  }
}

// MARK: Private enum
private enum ShowTitleEnum: String, Decodable {
  case show = "sim"
  case hide = "não"
}
