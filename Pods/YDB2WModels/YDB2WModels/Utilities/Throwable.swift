//
//  Throwable.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 23/06/21.
//

import Foundation

struct Throwable<T: Decodable>: Decodable {
  let result: Result<T, Error>

  init(from decoder: Decoder) throws {
    let catching = { try T(from: decoder) }
    result = Result(catching: catching )
  }
}
