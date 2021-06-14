//
//  YDSpaceyCommonStruct.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 12/05/21.
//

import Foundation

public class YDSpaceyCommonStruct: Decodable {
  public var id: String?
  public var component: YDSpaceyComponentDelegate?

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case component
  }

  public init(id: String?, component: YDSpaceyComponentDelegate) {
    self.id = id
    self.component = component
  }

  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try? container.decode(String.self, forKey: .id)

    // Grid
    if let grid = try? container.decode(YDSpaceyComponentGrid.self, forKey: .component),
       grid.type == .grid {
      component = grid
      return
    }

    // Banner Carrousel
    if let bannerCarrousel = try? container.decode(
        YDSpaceyComponentCarrouselBanner.self,
      forKey: .component
    ),
    bannerCarrousel.type == .bannerCarrousel {
      component = bannerCarrousel
      return
    }

    // Products Carrousel
    if let productsCarrousel = try? container.decode(YDSpaceyComponentCarrouselProduct.self, forKey: .component),
       productsCarrousel.type == .productCarrousel {
      component = productsCarrousel
      return
    }

    // NPS
    if let nps = try? container.decode(YDSpaceyComponentNPS.self, forKey: .component),
       nps.type == .nps {
      component = nps
      return
    }

    // Terms of Use
    if let terms = try? container.decode(
        YDSpaceyComponentTermsOfUse.self,
        forKey: .component
    ), terms.type == .termsOfUse {
      component = terms
      return
    }

    // Default
    if let common = try? container.decode(YDSpaceyCommonComponent.self, forKey: .component) {
      component = common
    } else {
      component = nil
    }
  }
}
