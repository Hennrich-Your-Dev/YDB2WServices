//
//  DateExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 02/11/20.
//

import Foundation

public extension Date {

  func toFormat(_ format: String = "yyyy-MM-dd") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }

  var calendar: Calendar {
    // Workaround to segfault on corelibs foundation https://bugs.swift.org/browse/SR-10147
    return Calendar(identifier: Calendar.current.identifier)
  }

  var isInFuture: Bool {
    return self > Date()
  }

  var isInPast: Bool {
    return self < Date()
  }

  var isInToday: Bool {
    return calendar.isDateInToday(self)
  }

  var isInYesterday: Bool {
    return calendar.isDateInYesterday(self)
  }

  /// SwifterSwift: Check if date is within tomorrow.
  ///
  ///   Date().isInTomorrow -> false
  ///
  var isInTomorrow: Bool {
    return calendar.isDateInTomorrow(self)
  }

  /// SwifterSwift: Check if date is within a weekend period.
  var isInWeekend: Bool {
    return calendar.isDateInWeekend(self)
  }

  /// SwifterSwift: Check if date is within a weekday period.
  var isWorkday: Bool {
    return !calendar.isDateInWeekend(self)
  }

  /// SwifterSwift: Check if date is within the current week.
  var isInCurrentWeek: Bool {
    return calendar.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
  }

  /// SwifterSwift: Check if date is within the current month.
  var isInCurrentMonth: Bool {
    return calendar.isDate(self, equalTo: Date(), toGranularity: .month)
  }

  /// SwifterSwift: Check if date is within the current year.
  var isInCurrentYear: Bool {
    return calendar.isDate(self, equalTo: Date(), toGranularity: .year)
  }

  /// SwifterSwift: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSS) from date.
  ///
  ///   Date().iso8601String -> "2017-01-12T14:51:29.574Z"
  ///
  var iso8601String: String {
    // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

    return dateFormatter.string(from: self).appending("Z")
  }
}
