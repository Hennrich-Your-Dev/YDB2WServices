//
//  YDManager+NextLives.swift
//  YDUtilities
//
//  Created by Douglas Hennrich on 23/06/21.
//

import Foundation
import YDExtensions

public struct YDManagerScheduleLive: Codable {
  public let id: String
  public let endTime: Date

  public init(id: String, endTime: Date) {
    self.id = id
    self.endTime = endTime
  }
}

public extension YDManager {
  class NextLives {
    // MARK: Properties
    public  static let shared = YDManager.NextLives()
    private let defaults = UserDefaults.standard
    private var lives: [YDManagerScheduleLive] = []

    // MARK: Init
    private init() {
      guard let data = defaults.object(forKey: YDConstants.UserDefaults.savedNextLives) as? Data,
            let saved = try? JSONDecoder().decode([YDManagerScheduleLive].self, from: data)
      else { return }

      pruneOldLives(from: saved)
    }

    // MARK: Actions
    private func pruneOldLives(from saved: [YDManagerScheduleLive]) {
      var cleanLives: [YDManagerScheduleLive] = saved
      var indexesToRemove: [Int] = []
      var needToSave = false

      for (index, curr) in cleanLives.enumerated() {
        guard let endTimePlusOne = Foundation.Calendar.current.date(byAdding: .day, value: 1, to: curr.endTime)
        else { continue }

        if endTimePlusOne.isInPast,
           cleanLives.at(index) != nil {
          indexesToRemove.append(index)

          if !needToSave {
            needToSave = true
          }
        }
      }

      if !indexesToRemove.isEmpty {
        indexesToRemove.reverse()
        indexesToRemove.forEach {
          if cleanLives.at($0) != nil {
            cleanLives.remove(at: $0)
          }
        }
      }

      lives = cleanLives

      if needToSave {
        save()
      }
    }

    private func save() {
      guard let encoded = try? JSONEncoder().encode(lives) else { return }
      defaults.set(encoded, forKey: YDConstants.UserDefaults.savedNextLives)
    }

    // MARK: Public
    public func add(_ live: YDManagerScheduleLive) {
      guard lives.firstIndex(where: { $0.id == live.id }) == nil
      else { return }

      lives.append(live)
      save()
    }

    public func checkIfExists(_ id: String) -> Bool {
      return lives.firstIndex(where: { $0.id == id }) != nil
    }
  }
}
