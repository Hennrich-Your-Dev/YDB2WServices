//
//  YDInvoice.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 15/07/21.
//

import Foundation

public typealias YDInvoices = [YDInvoice]

public class YDInvoice: Codable {
  // MARK: Properties
  public let uf: String
  public let url: String
  public var working: Bool
  public var directLink: Bool
  public var replaceString: Bool

  public var canOpen: Bool {
    return working && replaceString
  }

  // MARK: Init
  public init(
    uf: String,
    url: String,
    working: Bool,
    directLink: Bool,
    replaceString: Bool
  ) {
    self.uf = uf
    self.url = url
    self.working = working
    self.directLink = directLink
    self.replaceString = replaceString
  }

  // MARK: Actions
  public func getUrl(withCode code: String) -> URL? {
    guard let replaced = url.replacingOccurrences(
      of: "%codigo%",
      with: code
    ).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
    else {
      return nil
    }
    return URL(string: replaced)
  }
}
