//
//  Service+LasaClient.swift
//  YDB2WServices
//
//  Created by Douglas Hennrich on 04/05/21.
//

import Foundation

import YDB2WModels

public extension YDB2WService {
  func getLasaClientLogin(
    user: YDCurrentCustomer,
    onCompletion completion: @escaping (Result<YDLasaClientLogin, YDServiceError>) -> Void
  ) {
    let headers: [String: String] = [
      "Content-Type": "application/json",
      "Ocp-Apim-Subscription-Key": "953582bd88f84bdb9b3ad66d04eaf728"
    ]

    let parameters: [String: Any] = [
      "id_cliente": user.id,
      "access_code_cliente": user.accessToken
    ]

    let url = "\(lasaClient)/portalcliente/login"

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }

      self.service.request(
        withUrl: url,
        withMethod: .post,
        withHeaders: headers,
        andParameters: parameters
      ) { (response: Result<YDLasaClientLogin, YDServiceError>) in
        switch response {
          case .success(let userLogin):
            completion(.success(userLogin))

          case .failure(let error):
            completion(.failure(error))
        }
      }
    }
  }

  func getLasaClientInfo(
    with user: YDLasaClientLogin,
    onCompletion completion: @escaping (Result<YDLasaClientInfo, YDServiceError>) -> Void
  ) {
    guard let idLasa = user.idLasa,
          let token = user.token
    else {
      completion(
        .failure(
          YDServiceError(withMessage: "Erro desconhecido")
        )
      )
      return
    }

    let headers: [String: String] = [
      "Cache-Control": "0",
      "Ocp-Apim-Subscription-Key": "953582bd88f84bdb9b3ad66d04eaf728",
      "Authorization": "Bearer \(token)"
    ]

    let url = "\(lasaClient)/portalcliente/cliente/\(idLasa)"

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }

      self.service.request(
        withUrl: url,
        withMethod: .get,
        withHeaders: headers,
        andParameters: nil
      ) { (response: Swift.Result<YDLasaClientInfo, YDServiceError>) in
        switch response {
          case .success(let usersInfo):
            usersInfo.socialSecurity = user.socialSecurity
            completion(.success(usersInfo))

          case .failure(let error):
            completion(.failure(error))
        }
      }
    }
  }

  func updateLasaClientInfo(
    user: YDLasaClientLogin,
    parameters: [String: Any],
    onCompletion completion: @escaping (Result<Void, YDServiceError>) -> Void
  ) {
    guard let idLasa = user.idLasa,
          let token = user.token
    else {
      completion(
        .failure(
          YDServiceError(withMessage: "Erro desconhecido")
        )
      )
      return
    }

    let headers: [String: String] = [
      "Cache-Control": "0",
      "Ocp-Apim-Subscription-Key": "953582bd88f84bdb9b3ad66d04eaf728",
      "Authorization": "Bearer \(token)"
    ]

    let url = "\(lasaClient)/portalcliente/cliente/\(idLasa)"

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }

      self.service.request(
        withUrl: url,
        withMethod: .post,
        withHeaders: headers,
        andParameters: parameters
      ) { (response: Result<[String: String], YDServiceError>) in
        switch response {
          case .success:
            completion(.success(()))

          case .failure(let error):
            completion(.failure(error))
        }
      }
    }
  }

  func getLasaClientHistoric(
    with user: YDLasaClientLogin,
    onCompletion completion: @escaping (Result<[YDLasaClientHistoricData], YDServiceError>) -> Void
  ) {
    guard let token = user.token
    else {
      completion(
        .failure(
          YDServiceError(withMessage: "Erro desconhecido")
        )
      )
      return
    }

    let headers: [String: String] = [
      "Cache-Control": "0",
      "Ocp-Apim-Subscription-Key": "953582bd88f84bdb9b3ad66d04eaf728",
      "Authorization": "Bearer \(token)"
    ]

    let url = "\(lasaClient)/portalcliente/cliente/relatorio-historico/lista"

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }

      self.service.request(
        withUrl: url,
        withMethod: .get,
        withHeaders: headers,
        andParameters: nil
      ) { (response: Result<[YDLasaClientHistoricData], YDServiceError>) in
        switch response {
          case .success(let historic):
            let sorted = historic.sorted { (lhs, rhs) -> Bool in
              guard let dateLhs = lhs.dateWithDateType else { return false }
              guard let dateRhs = rhs.dateWithDateType else { return true }

              return dateLhs.compare(dateRhs) == .orderedDescending
            }
            
            completion(.success(sorted))

          case .failure(let error):
            completion(.failure(error))
        }
      }
    }
  }
}
