//
//  QueryString.swift
//  YDUtilities
//
//  Created by Douglas Hennrich on 17/12/20.
//

import Foundation

public func queryString(_ value: String, params: [String: String]) -> String? {
  var components = URLComponents(string: value)
  components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value) }

  return components?.url?.absoluteString
}
