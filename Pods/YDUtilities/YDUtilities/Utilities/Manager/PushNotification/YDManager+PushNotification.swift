//
//  YDManager+PushNotification.swift
//  YDUtilities
//
//  Created by Douglas Hennrich on 22/06/21.
//

import UIKit
import UserNotifications

public extension YDManager {
  class Notification {
    // MARK: Properties
    public static let shared = YDManager.Notification()
    private let notificationCenter = UNUserNotificationCenter.current()

    // MARK: Init
    private init() {}

    // MARK: Actions
    public func getNotificationStatus(onCompleted completed: @escaping (Bool) -> Void) {
      notificationCenter.getNotificationSettings { settings in
        completed(settings.authorizationStatus == .authorized)
      }
    }

    public func requestNotificationPermission(onCompleted completed: @escaping (Bool) -> Void) {
      getNotificationStatus { authorized in
        if !authorized {
          let options: UNAuthorizationOptions = [.alert, .sound, .badge]
          self.notificationCenter
            .requestAuthorization(options: options) { didAllow, error in
              completed(didAllow)
            }
        } else {
          completed(true)
        }
      }
    }

    public func scheduleLocalNotification(
      date: Date,
      title: String,
      message: String,
      mock: Bool = false,
      onCompleted completed: @escaping () -> Void
    ) {
      let dateComponents = Foundation.Calendar.current
        .dateComponents([.month, .day, .hour, .minute], from: date)

      let content = UNMutableNotificationContent()
      content.title = title
      content.body = message
      content.sound = .default

      if mock {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(
          identifier: UUID().uuidString,
          content: content,
          trigger: trigger
        )
        notificationCenter.add(request)
        completed()
        //
      } else {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        let request = UNNotificationRequest(
          identifier: UUID().uuidString,
          content: content,
          trigger: trigger
        )
        notificationCenter.add(request)
        completed()
      }
    }
  }
}
