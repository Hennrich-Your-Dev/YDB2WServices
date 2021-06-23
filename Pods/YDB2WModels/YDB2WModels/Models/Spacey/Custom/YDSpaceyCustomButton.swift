//
//  YDSpaceyCustomButton.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 22/06/21.
//

import Foundation

public class YDSpaceyCustomButton: YDSpaceyCustomComponentDelegate {
  public var knewType: YDSpaceyCustomComponentType = .button
  public var id: String?
  public var children: [YDSpaceyComponentsTypes] = []
  public var type: YDSpaceyComponentsTypes.Types = .custom
  public var title: String?

  public init(id: String?, title: String?) {
    self.id = id
    self.title = title
  }
}
