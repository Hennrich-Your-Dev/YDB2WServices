//
//  Throwable.swift
//  YDMHome
//
//  Created by Douglas Hennrich on 15/10/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import Foundation

public struct Throwable<T: Decodable>: Decodable {

  public let result: Result<T, Error>

  public init(from decoder: Decoder) throws {
		let catching = { try T(from: decoder) }
		result = Result(catching: catching )
	}
}
