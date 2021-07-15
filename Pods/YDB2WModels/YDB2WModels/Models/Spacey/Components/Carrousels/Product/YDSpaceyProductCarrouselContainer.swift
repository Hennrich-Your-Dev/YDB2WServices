//
//  YDSpaceyProductCarrouselContainer.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 10/05/21.
//

import UIKit

public struct YDSpaceyProductCarrouselContainer {
  public var id: Int
  public var items: [YDSpaceyProduct]
  public var ids: [[ (id: String, sellerId: String) ]]
  public var pageNumber: Int
  public var currentRectList: CGFloat?

  public init(
    id: Int,
    items: [YDSpaceyProduct],
    ids: [[ (id: String, sellerId: String) ]],
    pageNumber: Int,
    currentRectList: CGFloat?
  ) {
    self.id = id
    self.items = items
    self.ids = ids
    self.pageNumber = pageNumber
    self.currentRectList = currentRectList
  }
}
