//
//  YDLasaClientInfo.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 04/05/21.
//

import Foundation

public class YDLasaClientInfo: Codable {
  public let name: String?
  public var socialSecurity: String?
  public let gender: String?
  public let relationship: String?
  public let birthday: String?
  public let email: String?
  public let cellPhone: String?
  public let homePhone: String?
  public let date: String?
  public let street: String?
  public let streetNumber: String?
  public let streetNumberComplement: String?
  public let CEP: String?
  public let neighborhood: String?
  public let city: String?
  public let state: String?

  public var marketing: Bool = false
  public var terms: Bool = false

  public var formattedAddres: String? {
    guard var address = street else { return nil }

    if let number = streetNumber,
       !number.isEmpty {
      address += ", \(number)"
    }

    if let complement = streetNumberComplement,
       !complement.isEmpty {
      address += ", \(complement)"
    }

    if let neighborhood = neighborhood,
       !neighborhood.isEmpty {
      address += ", \(neighborhood)"
    }

    if let city = city,
       !city.isEmpty {
      address += " - \(city)"
    }

    if let state = state,
       !state.isEmpty {
      address += ", \(state)"
    }

    if let cep = CEP,
       !cep.isEmpty {
      address += " - \(cep)"
    }

    return address
  }

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case name = "nome_completo"
    case socialSecurity = "cpf"
    case gender = "sexo"
    case relationship = "estado_civil_desc"
    case birthday = "data_nascimento"
    case email
    case cellPhone = "telefone_celular"
    case homePhone = "telefone_residencial"
    case marketing = "optin_marketing"
    case terms = "optin_termos_condicoes"
    case date = "data_atualizacao"
    case street = "logradouro"
    case streetNumber = "numero"
    case streetNumberComplement = "complemento"
    case CEP = "cep"
    case neighborhood = "bairro"
    case city = "municipio"
    case state = "uf"
  }

  // MARK: Actions
  public func getUserDataSets() -> [YDLasaClientDataSet] {
    var data: [YDLasaClientDataSet] = []

    if let name = name,
       !name.isEmpty {
      data.append(YDLasaClientDataSet(title: "nome", value: name))
    }

    if let socialSecurity = socialSecurity,
       !socialSecurity.isEmpty,
       let formatedSocialSecurity = YDLasaClientDataSet.formatSocialSecurityNumber(socialSecurity) {
      data.append(YDLasaClientDataSet(title: "cpf", value: formatedSocialSecurity))
    }

    if let dateString = birthday,
       !dateString.isEmpty,
       let formatedDate = YDLasaClientDataSet.formatDate(dateString) {
      data.append(
        YDLasaClientDataSet(
          title: "data de nascimento",
          value: formatedDate
        )
      )
    }

    if let gender = gender,
       !gender.isEmpty {
      data.append(YDLasaClientDataSet(title: "sexo", value: gender))
    }

    if let relationship = relationship,
       !relationship.isEmpty {
      data.append(YDLasaClientDataSet(title: "estado civil", value: relationship))
    }

    if let email = email,
       !email.isEmpty {
      data.append(YDLasaClientDataSet(title: "e-mail", value: email))
    }

    if let cell = cellPhone,
       !cell.isEmpty {
      var phoneData = YDLasaClientDataSet(title: "telefone celular",
                                  value: YDLasaClientDataSet.formatPhoneNumber(cell))

      if let home = homePhone,
         !home.isEmpty {
        phoneData.doubleTitle = "telefone residencial"
        phoneData.doubleValue = YDLasaClientDataSet.formatPhoneNumber(home)
      }

      data.append(phoneData)
    }

    if let address = formattedAddres {
      data.append(YDLasaClientDataSet(title: "endereço", value: address))
    }

    data.append(YDLasaClientDataSet(type: .separator, title: "", value: nil))

    data.append(YDLasaClientDataSet(type: .marketing, title: "", value: nil))

    data.append(YDLasaClientDataSet(type: .separator, title: "", value: nil))

    data.append(YDLasaClientDataSet(type: .termsAndSave, title: "", value: nil))

    return data
  }
}
