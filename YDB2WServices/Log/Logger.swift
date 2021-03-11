//
//  Logger.swift
//  YDMHome
//
//  Created by Douglas Hennrich on 22/09/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import Foundation

public enum LoggerLevel: Int {
  case debug = 0
  case info
  case warning
  case error
  case none
}

public class Logger {

  private let className: String
  private static var destinations: [LoggerDestination] = [LoggerConsoleDestination()]
  let dateParam = "$date"
  let classParam = "$class"
  let methodParam = "$method"
  let lineParam = "$line"
  let columnParam = "$column"
  let messageParam = "$message"
  var formatter: String
  var dateTimeStyle = "yyyy-MM-dd HH:mm"

  private init(className: String) {
    self.className = className
    formatter = "[\(dateParam)] - [\(classParam):\(methodParam)] [\(lineParam):\(columnParam)] \(messageParam)"
  }

  public static func forClass(_ clazz: Any.Type) -> Logger {
    let logger = Logger(className: String(describing: clazz.self))
    return logger
  }

  public static func addDestination(destination: LoggerDestination) {
    Logger.destinations.append(destination)
  }

  private func getMessage(
    _ function: String,
    _ line: Int,
    _ column: Int,
    _ args: CVarArg
  ) -> String {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = self.dateTimeStyle

    return formatter.replacingOccurrences(of: classParam, with: className)
      .replacingOccurrences(of: methodParam, with: function)
      .replacingOccurrences(of: lineParam, with: "\(line)")
      .replacingOccurrences(of: columnParam, with: "\(column)")
      .replacingOccurrences(of: messageParam, with: String.init(format: "%@", args))
      .replacingOccurrences(of: dateParam, with: dateformatter.string(from: Date()) )
  }

  public func info(
    _ args: CVarArg?,
    function: String = #function,
    line: Int = #line,
    column: Int = #column
  ) {
    guard let args = args else { return }
    let message = getMessage(function, line, column, args)

    for destination in Logger.destinations {
      destination.send(message: "🔵 INFO: \(message)", level: .info)
    }
  }

  public func error(
    _ args: CVarArg?,
    function: String = #function,
    line: Int = #line,
    column: Int = #column
  ) {
    guard let args = args else { return }
    let message = getMessage(function, line, column, args)

    for destination in Logger.destinations {
      destination.send(message: "🛑 ERROR: \(message)", level: .error)
    }
  }

  public func warning(
    _ args: CVarArg?,
    function: String = #function,
    line: Int = #line,
    column: Int = #column
  ) {
    guard let args = args else { return }
    let message = getMessage(function, line, column, args)

    for destination in Logger.destinations {
      destination.send(message: "⚠️ WARNING: \(message)", level: .warning)
    }
  }

  public func debug(
    _ args: CVarArg?,
    function: String = #function,
    line: Int = #line,
    column: Int = #column
  ) {
    guard let args = args else { return }
    let message = getMessage(function, line, column, args)

    for destination in Logger.destinations {
      destination.send(message: "✳️ DEBUG: \(message)", level: .debug)
    }
  }
}

public protocol LoggerDestination {
  func send(message: String, level: LoggerLevel)
}

public class LoggerConsoleDestination: LoggerDestination {
  public func send(message: String, level: LoggerLevel) {
    print(message)
  }
}
