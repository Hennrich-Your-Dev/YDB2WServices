//
//  YDManager+Quiz.swift
//  YDUtilities
//
//  Created by Douglas Hennrich on 28/07/21.
//

import Foundation

public extension YDManager {
  class Quiz {
    // MARK: Properties
    public  static let shared = YDManager.Quiz()
    private let defaults = UserDefaults.standard
    private var howManyTimes: Int

    // MARK: Init
    private init() {
      howManyTimes = defaults.integer(
        forKey: YDConstants.UserDefaults.howManyTimesQuizWereOpened
      )
    }

    // MARK: Actions
    private func save() {
      defaults.set(howManyTimes, forKey: YDConstants.UserDefaults.howManyTimesQuizWereOpened)
    }

    // MARK: Public
    public func increment() {
      howManyTimes += 1
      save()
    }

    public func checkIfCanOpen() -> Bool {
      return howManyTimes <= 2
    }
  }
}
