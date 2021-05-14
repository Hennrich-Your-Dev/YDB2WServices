//
//  UIStateEnum.swift
//  YDUtilities
//
//  Created by Douglas Hennrich on 07/04/21.
//

import Foundation

public enum UIStateEnum {
  case normal
  case loading
  case error
  case empty
}

public protocol UIStateDelegate {
  func changeUIState(with type: UIStateEnum)
}
