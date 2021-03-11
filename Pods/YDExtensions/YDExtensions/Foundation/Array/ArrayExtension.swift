//
//  ArrayExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 02/11/20.
//

import Foundation

public extension Array {
  func at(_ index: Int) -> Element? {
    return 0 <= index && index < count ? self[index] : nil
  }

  func inBatches(ofSize batchSize: Int) -> [[Element]] {
    return stride(from: 0, to: self.count, by: batchSize).map {
        Array(self[$0..<Swift.min($0 + batchSize, self.count)])
    }
  }
}
