//
//  YDInvoice.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 15/07/21.
//

import Foundation

public typealias YDInvoices = [YDInvoice]

public class YDInvoice: Codable {
  public let uf: String?
  public let url: String?
  public var working: Bool?
  public var directLink: Bool?
  public var replaceString: Bool?

  public init(
    uf: String?,
    url: String?,
    working: Bool?,
    directLink: Bool?,
    replaceString: Bool?
  ) {
    self.uf = uf
    self.url = url
    self.working = working
    self.directLink = directLink
    self.replaceString = replaceString
  }
}
