//
//  YDCurrent.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 05/05/21.
//

import Foundation

public struct YDCurrentCustomer: Codable {
  public var id: String
  public var email: String?
  public var firstName: String?
  public var fullName: String?
  public var accessToken: String

  public var clientLasaToken: String?
  public var clientLasaStoreId: String?

  public init(
    id: String,
    email: String? = nil,
    firstName: String? = nil,
    fullName: String? = nil,
    accessToken: String,
    clientLasaToken: String? = nil,
    clientLasaStoreId: String? = nil
  ) {
    self.id = id
    self.email = email
    self.firstName = firstName
    self.fullName = fullName
    self.accessToken = accessToken
    self.clientLasaToken = clientLasaToken
    self.clientLasaStoreId = clientLasaStoreId
  }
}
