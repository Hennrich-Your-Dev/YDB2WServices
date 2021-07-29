//
//  YDManager+LiveNPS.swift
//  YDUtilities
//
//  Created by Douglas Hennrich on 11/07/21.
//

import Foundation
import YDExtensions

public class YDManagerLiveNPS: Codable {
  public let id: String?
  public let spaceyId: String?
  public var question: String?
  public var answer: String?

  public init(
    id: String?,
    spaceyId: String?,
    question: String?,
    answer: String?
  ) {
    self.id = id
    self.spaceyId = spaceyId
    self.question = question
    self.answer = answer
  }
}

public extension YDManager {
  class LivesNPS {
    // MARK: Properties
    public static let shared = YDManager.LivesNPS()
    private let defaults = UserDefaults.standard
    private var livesNPS: [YDManagerLiveNPS] = []
    public var liveIdEnabled = true

    // MARK: Init
    private init() {
      guard let data = defaults.object(forKey: YDConstants.UserDefaults.savedLiveNPS) as? Data,
            let saved = try? JSONDecoder().decode([YDManagerLiveNPS].self, from: data)
      else { return }

      livesNPS = saved
    }

    // MARK: Actions
    private func save() {
      guard let encoded = try? JSONEncoder().encode(livesNPS) else { return }
      defaults.set(encoded, forKey: YDConstants.UserDefaults.savedLiveNPS)
    }

    // MARK: Public
    public func add(_ nps: YDManagerLiveNPS) {
      if liveIdEnabled {
        guard livesNPS.firstIndex(where: { $0.spaceyId == nps.spaceyId && $0.id == nps.id }) == nil
        else { return }

        livesNPS.append(nps)
        save()
        return
      }

      guard livesNPS.firstIndex(where: { $0.id == nps.id }) == nil
      else { return }

      livesNPS.append(nps)
      save()
    }

    public func get(id: String?, spaceyId: String?) -> YDManagerLiveNPS? {
      if liveIdEnabled {
        return livesNPS.first(
          where: {
            $0.spaceyId == spaceyId && $0.id == id
          }
        )
      }

      return livesNPS.first(where: { $0.id == id })
    }
  }
}
