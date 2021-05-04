//
//  YDLasaClientLogin.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 04/05/21.
//

import Foundation

public class YDLasaClientLogin: Decodable {
  public let socialSecurity: String?
  public let name: String?
  public let email: String?
  public let token: String?
  public let idLasa: String?

  enum CodingKeys: String, CodingKey {
    case socialSecurity = "cpf"
    case name = "nome"
    case email
    case token
    case idLasa = "id_lasa"
  }
}
