//
//  YDSpaceyComponentDelegate.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 14/05/21.
//

import UIKit

// MARK: Delegate
public protocol YDSpaceyComponentDelegate: Decodable {
  var id: String? { get set }
  var children: [YDSpaceyComponentsTypes] { get set }
  var type: YDSpaceyComponentsTypes.Types { get set }
}

// MARK: Custom component
public protocol YDSpaceyCustomComponentDelegate: YDSpaceyComponentDelegate {
  var knewType: YDSpaceyCustomComponentType { get }
}

public enum YDSpaceyCustomComponentType: String, Decodable {
  case countDown
  case button
  case card
  case title
  case unknow
}
