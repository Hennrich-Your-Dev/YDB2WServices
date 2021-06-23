//
//  YDManager+Calendar.swift
//  YDUtilities
//
//  Created by Douglas Hennrich on 23/06/21.
//

import UIKit
import EventKit
import YDB2WModels

public extension YDManager {
  class Calendar {
    // MARK: Properties
    public static let shared = Calendar()
    private var currentCallback: ((_ success: Bool, _ status: EKAuthorizationStatus?) -> Void)?
    private let eventStore = EKEventStore()

    // MARK: Init
    private init() {}

    // MARK: Private
    private func add(_ live: YDSpaceyComponentNextLive, reminderTimeInMinutes: Double) {
      guard let startTime = live.initialDateAsDate,
            let endTime = live.finalDateAsDate
      else {
        currentCallback?(false, nil)
        return
      }

      let calendar = eventStore.defaultCalendarForNewEvents
      let event = EKEvent(eventStore: eventStore)
      event.title = live.name
      event.startDate = startTime
      event.endDate = endTime
      event.calendar = calendar

      let timeToFire = -reminderTimeInMinutes * 60
      event.addAlarm(EKAlarm(relativeOffset: timeToFire))

      try? eventStore.save(event, span: .thisEvent, commit: true)
      currentCallback?(true, nil)
      currentCallback = nil
    }

    // MARK: Public
    public func schedule(
      live: YDSpaceyComponentNextLive,
      reminderTimeInMinutes: Double,
      onCompletion completed: @escaping (_ success: Bool, _ status: EKAuthorizationStatus?) -> Void
    ) {
      currentCallback = completed

      switch EKEventStore.authorizationStatus(for: .event) {
        case .notDetermined:
          DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.eventStore.requestAccess(to: .event) { granted, _ in
              if granted {
                self.add(live, reminderTimeInMinutes: reminderTimeInMinutes)
              } else {
                completed(false, .denied)
                self.currentCallback = nil
              }
            }
          }
        case .authorized:
          add(live, reminderTimeInMinutes: reminderTimeInMinutes)

        case .denied:
          completed(false, .denied)
          currentCallback = nil
        default:
          break
      }
    }
  }
}
