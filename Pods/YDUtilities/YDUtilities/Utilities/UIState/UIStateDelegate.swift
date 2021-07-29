//
//  UIStateEnum.swift
//  YDUtilities
//
//  Created by Douglas Hennrich on 07/04/21.
//

import Foundation

public enum YDUIStateEnum {
  case normal
  case loading
  case error
  case empty
}

public protocol YDUIStateDelegate {
  var stateView: YDUIStateEnum { get set }

  func changeUIState(with type: YDUIStateEnum)
}
