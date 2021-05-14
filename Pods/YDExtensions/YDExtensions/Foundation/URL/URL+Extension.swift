//
//  URL+Extension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 09/05/21.
//

import Foundation

public extension URL {
  var queryParameters: [String: String]? {
    guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
          let queryItems = components.queryItems
    else { return nil }

    return queryItems.reduce(into: [String: String]()) { (result, item) in
      result[item.name] = item.value
    }
  }
}
