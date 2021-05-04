//
//  YDLasaClientDataSet.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 04/05/21.
//

import Foundation

import YDExtensions

public enum YDLasaClientDataSetTypeEnum {
  case info
  case separator
  case marketing
  case termsAndSave
}

public struct YDLasaClientDataSet {
  public var type: YDLasaClientDataSetTypeEnum = .info
  public let title: String
  public let value: String?
  public var doubleTitle: String? = nil
  public var doubleValue: String? = nil

  // MARK: Actions
  public static func formatDate(_ date: String, toFormat: String = "dd/MM/yyyy") -> String? {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

    return dateFormatterGet.date(from: date)?.toFormat(toFormat)
  }

  public static func formatPhoneNumber(_ number: String?) -> String? {
    guard let numberUnwarp = number else { return nil }

    let cleanNumber = numberUnwarp.replacingOccurrences(
      of: "[^0-9]",
      with: "",
      options: .regularExpression
    )

    switch cleanNumber.count {
      case 11:
        return cleanNumber.applyPatternOnNumbers(pattern: "(##) #####-####", replacmentCharacter: "#")

      case 10:
        return cleanNumber.applyPatternOnNumbers(pattern: "(##) ####-####", replacmentCharacter: "#")

      case 9:
        return cleanNumber.applyPatternOnNumbers(pattern: "#####-####", replacmentCharacter: "#")

      case 8:
        return cleanNumber.applyPatternOnNumbers(pattern: "####-####", replacmentCharacter: "#")

      default:
        return number
    }
  }

  public static func formatSocialSecurityNumber(_ number: String?, toFormat: String = "###.###.###-##") -> String? {
    guard let number = number else { return nil }

    let cleanNumber = number.replacingOccurrences(
      of: "[^0-9]",
      with: "",
      options: .regularExpression
    )

    if cleanNumber.count == 11 {
      return number.applyPatternOnNumbers(pattern: toFormat, replacmentCharacter: "#")
    } else {
      return number.applyPatternOnNumbers(pattern: "##.###.###/####-##", replacmentCharacter: "#")
    }
  }
}
