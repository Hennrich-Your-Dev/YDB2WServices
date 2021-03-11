//
//  EncodableExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 01/11/20.
//

import Foundation

public extension Encodable {

  func asDictionary() throws -> [String: Any] {
    do {
      let data = try JSONEncoder().encode(self)
      let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
      if let dictionary = jsonObject as? [String: Any] {
        return dictionary
      }
      return [:]
    } catch {
      throw error
    }
  }
}
