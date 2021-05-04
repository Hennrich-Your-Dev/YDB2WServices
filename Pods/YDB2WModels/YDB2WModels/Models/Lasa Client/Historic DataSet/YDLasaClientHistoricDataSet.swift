//
//  YDLasaClientHistoricDataSet.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 04/05/21.
//

import Foundation

public class YDLasaClientHistoricData: Codable {
  public let origin: String
  public let objective: String
  public let date: String?
  public let fields: YDLasaClientHistoricDataFields

  public var formattedDate: String? {
    guard let date = date else { return nil }
    let toFormat = "DD/MM/yyyy"
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-DD'T'HH:mm:ss"
    return formatter.date(from: date)?.toFormat(toFormat)
  }

  public var dateWithDateType: Date? {
    guard let date = date else { return nil }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-DD'T'HH:mm:ss"

    return formatter.date(from: date)
  }

  public func getHistoricDataSet() -> [YDLasaClientHistoricDataSet] {
    var data: [YDLasaClientHistoricDataSet] = []

    if let socialSecurity = fields.socialSecurity,
       !socialSecurity.isEmpty,
       let formatedSocialSecurity = YDLasaClientDataSet
        .formatSocialSecurityNumber(socialSecurity) {
      let titleName = formatedSocialSecurity.count == 14 ? "cpf" : "cnpj"
      data.append(YDLasaClientHistoricDataSet(title: titleName, value: formatedSocialSecurity))
    }

    if let name = fields.name,
       !name.isEmpty {
      data.append(YDLasaClientHistoricDataSet(title: "nome", value: name))
    }

    if let email = fields.email,
       !email.isEmpty {
      data.append(YDLasaClientHistoricDataSet(title: "e-mail", value: email))
    }

    if let cell = fields.cellPhone,
       !cell.isEmpty {
      let phoneData = YDLasaClientHistoricDataSet(
        title: "telefone celular",
        value: YDLasaClientDataSet.formatPhoneNumber(cell) ?? ""
      )

      data.append(phoneData)
    }

    if let home = fields.homePhone,
       !home.isEmpty {
      let phoneData = YDLasaClientHistoricDataSet(
        title: "telefone residencial",
        value: YDLasaClientDataSet.formatPhoneNumber(home) ?? ""
      )

      data.append(phoneData)
    }

    if let address = fields.address,
       !address.isEmpty {
      data.append(YDLasaClientHistoricDataSet(title: "endereço", value: address))
    }

    if let relationship = fields.relationship,
       !relationship.isEmpty {
      data.append(YDLasaClientHistoricDataSet(title: "estado civil", value: relationship))
    }

    return data.compactMap { $0 }
  }

  enum CodingKeys: String, CodingKey {
    case date = "data_atualizacao"
    case origin = "origem"
    case objective = "finalidade"
    case fields = "campos"
  }

  // Init
  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    if let originString = try? container.decode(String.self, forKey: .origin) {
      origin = originString.isEmpty ? "não informado" : originString
    } else {
      origin = "não informado"
    }

    if let objectiveString = try? container.decode(String.self, forKey: .objective) {
      objective = objectiveString.isEmpty ? "não informado" : objectiveString
    } else {
      objective = "não informado"
    }

    date = try? container.decode(String.self, forKey: .date)
    fields = try container.decode(YDLasaClientHistoricDataFields.self, forKey: .fields)
  }
}

public class YDLasaClientHistoricDataFields: Codable {
  public let socialSecurity: String?
  public let name: String?
  public let email: String?
  public let homePhone: String?
  public let cellPhone: String?
  public let address: String?
  public let relationship: String?

  enum CodingKeys: String, CodingKey {
    case socialSecurity = "CPF_CNPJ"
    case name = "Nome"
    case email = "Email"
    case homePhone = "Telefone_residencial"
    case cellPhone = "Telefone_celular"
    case address = "Endereco"
    case relationship = "Estado_civil"
  }
}

public struct YDLasaClientHistoricDataSet: Codable {
  public let title: String
  public let value: String
}
