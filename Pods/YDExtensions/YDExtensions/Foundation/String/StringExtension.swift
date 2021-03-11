//
//  StringExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 02/11/20.
//

import Foundation

public extension String {

  static func loremIpsum(ofLength length: Int = 445) -> String {
    guard length > 0 else { return "" }

    // https://www.lipsum.com/
    let loremIpsum = """
          Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
          """
    if loremIpsum.count > length {
      return String(loremIpsum[loremIpsum.startIndex..<loremIpsum.index(loremIpsum.startIndex, offsetBy: length)])
    }
    return loremIpsum
  }

  func date(withFormat format: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: self)
  }

  func withQueryString(params: [String: String]) -> String? {
    var components = URLComponents(string: self)
    components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value) }

    return components?.url?.absoluteString
  }

  func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String {
    var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
    for index in 0 ..< pattern.count {
      guard index < pureNumber.count else { return pureNumber }
      let stringIndex = String.Index(utf16Offset: index, in: self)
      let patternCharacter = pattern[stringIndex]
      guard patternCharacter != replacmentCharacter else { continue }
      pureNumber.insert(patternCharacter, at: stringIndex)
    }
    return pureNumber
  }
}

// MARK: Regex
public extension String {

  var phoneRegexPattern: String {
    return "/^(?:(?:\\+|00)?(55)\\s?)?(?:\\(?([1-9][0-9])\\)?\\s?)?(?:((?:9\\d|[2-9])\\d{3})\\-?(\\d{4}))$/"
  }

  var isValidEmail: Bool {
    matches("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
  }

  var containsOnlyDigits: Bool {
    let notDigits = NSCharacterSet.decimalDigits.inverted
    return rangeOfCharacter(from: notDigits, options: String.CompareOptions.literal, range: nil) == nil
  }

  var containsOnlyLetters: Bool {
    let notLetters = NSCharacterSet.letters.inverted
    return rangeOfCharacter(from: notLetters, options: String.CompareOptions.literal, range: nil) == nil
  }

  var isAlphanumeric: Bool {
    let notAlphanumeric = NSCharacterSet.decimalDigits.union(NSCharacterSet.letters).inverted
    return rangeOfCharacter(from: notAlphanumeric, options: String.CompareOptions.literal, range: nil) == nil
  }

  func matches(_ expression: String) -> Bool {
    if let range = range(of: expression, options: .regularExpression, range: nil, locale: nil) {
      return range.lowerBound == startIndex && range.upperBound == endIndex
    } else {
      return false
    }
  }
  
}
