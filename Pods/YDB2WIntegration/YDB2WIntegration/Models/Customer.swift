//
//  Customer.swift
//  YDIntegration
//
//  Created by Douglas Hennrich on 27/10/20.
//

import Foundation

public struct YDCurrentCustomer: Codable {
  public var id: String
  public var email: String?
  public let firstName: String?
  public let fullName: String?
  public let accessToken: String
  public let clientLasaToken: String?

  public init(
    id: String,
    email: String? = nil,
    firstName: String? = nil,
    fullName: String? = nil,
    accessToken: String,
    clientLasaToken: String? = nil
  ) {
    self.id = id
    self.email = email
    self.firstName = firstName
    self.fullName = fullName
    self.accessToken = accessToken
    self.clientLasaToken = clientLasaToken
  }
}
