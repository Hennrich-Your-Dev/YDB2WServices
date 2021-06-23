//
//  YDSpaceyCustomCountDown.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 22/06/21.
//

import Foundation

public class YDSpaceyCustomCountDown: YDSpaceyCustomComponentDelegate {
  public var knewType: YDSpaceyCustomComponentType = .countDown
  public var id: String?
  public var children: [YDSpaceyComponentsTypes] = []
  public var type: YDSpaceyComponentsTypes.Types = .custom

  public init(id: String?) {
    self.id = id
  }
}
