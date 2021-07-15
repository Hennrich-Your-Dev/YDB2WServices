//
//  YDSpaceyCustomNextLive.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 06/07/21.
//

import Foundation

public class YDSpaceyCustomNextLive: YDSpaceyCustomComponentDelegate {
  public var knewType: YDSpaceyCustomComponentType = .nextLive
  public var id: String?
  public var title: String?
  public var children: [YDSpaceyComponentsTypes] = []
  public var type: YDSpaceyComponentsTypes.Types = .custom
  public var live: YDSpaceyComponentNextLive?

  public init(
    id: String?,
    live: YDSpaceyComponentNextLive?
  ) {
    self.id = id
    self.live = live
  }
}
