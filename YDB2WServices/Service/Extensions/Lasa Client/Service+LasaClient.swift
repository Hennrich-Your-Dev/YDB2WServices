//
//  Service+LasaClient.swift
//  YDB2WServices
//
//  Created by Douglas Hennrich on 04/05/21.
//

import Foundation

import Alamofire
import YDB2WModels
import YDExtensions

// MARK: Delegate
public protocol YDB2WServiceLasaClientDelegate {
  func offlineOrdersGetOrders(
    userToken token: String,
    page: Int,
    limit: Int,
    onCompletion completion: @escaping (Swift.Result<YDOfflineOrdersOrdersList, YDServiceError>) -> Void
  )

  func getLasaClientLogin(
    user: YDCurrentCustomer,
    socialSecurity: String?,
    onCompletion completion: @escaping (Swift.Result<YDLasaClientLogin, YDServiceError>) -> Void
  )

  func getLasaClientInfo(
    with user: YDLasaClientLogin,
    onCompletion completion: @escaping (Swift.Result<YDLasaClientInfo, YDServiceError>) -> Void
  )

  func updateLasaClientInfo(
    user: YDLasaClientLogin,
    parameters: [String: Any],
    onCompletion completion: @escaping (Swift.Result<Void, YDServiceError>) -> Void
  )

  func getLasaClientHistoric(
    with user: YDLasaClientLogin,
    onCompletion completion: @escaping (Swift.Result<[YDLasaClientHistoricData], YDServiceError>) -> Void
  )
  
  func getLasaClientQuizzes(
    userToken token: String,
    onCompletion completion: @escaping (Swift.Result<[YDB2WModels.YDQuiz], YDServiceError>) -> Void
  )
}

// MARK: Conform
public extension YDB2WService {
  func offlineOrdersGetOrders(
    userToken token: String,
    page: Int,
    limit: Int,
    onCompletion completion: @escaping (Swift.Result<YDOfflineOrdersOrdersList, YDServiceError>) -> Void
  ) {
    let url = "\(lasaClient)/portalcliente/cliente/cupons/lista"
    let headers = [
      "Authorization": "Bearer \(token)",
      "Ocp-Apim-Subscription-Key": "953582bd88f84bdb9b3ad66d04eaf728"
    ]
    let parameters = [
      "page_number": page,
      "limite_page": limit
    ]

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }

      self.service.requestWithFullResponse(
        withUrl: url,
        withMethod: .get,
        withHeaders: headers,
        andParameters: parameters
      ) { (response: DataResponse<Data>?) in
        guard let response = response,
              let data = response.data
        else {
          completion(.failure(YDServiceError.badRequest))
          return
        }

        if data.isEmpty {
          completion(.success([]))
          return
        }

        do {
          let orders = try JSONDecoder().decode(
            YDOfflineOrdersOrdersList.self,
            from: data
          )

          completion(.success(orders))

        } catch let error as NSError {
          completion(.failure(YDServiceError(error: error)))
        }
      }
    }
  }

  func getLasaClientLogin(
    user: YDCurrentCustomer,
    socialSecurity: String?,
    onCompletion completion: @escaping (Swift.Result<YDLasaClientLogin, YDServiceError>) -> Void
  ) {
    let headers: [String: String] = [
      "Content-Type": "application/json",
      "Ocp-Apim-Subscription-Key": "953582bd88f84bdb9b3ad66d04eaf728"
    ]

    var parameters: [String: Any] = [
      "id_cliente": user.id,
      "access_code_cliente": user.accessToken
    ]

    if let socialSecurity = socialSecurity {
      parameters["cpf"] = socialSecurity
    }

    let url = "\(lasaClient)/portalcliente/login"

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }

      self.service.request(
        withUrl: url,
        withMethod: .post,
        withHeaders: headers,
        andParameters: parameters
      ) { (response: Swift.Result<YDLasaClientLogin, YDServiceError>) in
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
    onCompletion completion: @escaping (Swift.Result<YDLasaClientInfo, YDServiceError>) -> Void
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
    onCompletion completion: @escaping (Swift.Result<Void, YDServiceError>) -> Void
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
      ) { (response: Swift.Result<[String: String], YDServiceError>) in
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
    onCompletion completion: @escaping (Swift.Result<[YDLasaClientHistoricData], YDServiceError>) -> Void
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
      ) { (response: Swift.Result<[YDLasaClientHistoricData], YDServiceError>) in
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
  
  func getLasaClientQuizzes(
    userToken token: String,
    onCompletion completion: @escaping (Swift.Result<[YDB2WModels.YDQuiz], YDServiceError>) -> Void
  ) {
    let headers: [String: String] = [
      "Authorization": "Bearer \(token)"
    ]

    let url = "\(lasaClient)/portalcliente/cliente/relatorio-historico/lista"

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }
      
      var quizzes: [YDB2WModels.YDQuiz] = []
      
      for n in 1...5 {
        let rightId = UUID().uuidString
        
        let quiz = YDB2WModels.YDQuiz(
          id: "\(n)",
          title: "Pergunta n\(n)?",
          choices: [
            YDQuizChoice(id: UUID().uuidString, title: "Escolha fake \(n)"),
            YDQuizChoice(id: rightId, title: "Escolha fake \(n)"),
            YDQuizChoice(id: UUID().uuidString, title: "Escolha fake \(n)"),
            YDQuizChoice(id: UUID().uuidString, title: .lorem())
          ],
          answer: rightId,
          type: .choices
        )
        quizzes.append(quiz)
      }
      
      completion(.success(quizzes))
//      self.service.request(
//        withUrl: url,
//        withMethod: .get,
//        withHeaders: headers,
//        andParameters: nil
//      ) { (response: Swift.Result<[YDB2WModels.YDQuiz], YDServiceError>) in
//        switch response {
//          case .success(let interface):
//            let quizzes = interface.perguntas.map {
//              YDB2WModels.YDQuiz(id: $0.id, title: $0.title, choices: $0.escolhas)
//            }
//            completion(.success(quizzes))
//
//          case .failure(let error):
//            completion(.failure(error))
//        }
//      }
    }
  }
}
