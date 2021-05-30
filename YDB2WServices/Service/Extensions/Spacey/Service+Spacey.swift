//
//  Service+Spacey.swift
//  YDB2WServices
//
//  Created by Douglas Hennrich on 14/05/21.
//

import Foundation

import Alamofire
import YDB2WModels

// Delegate
public protocol YDB2WServiceSpaceyDelegate {
  func getSpacey(
    spaceyId: String,
    customApi: String?,
    onCompletion completion: @escaping (Swift.Result<YDSpacey, YDServiceError>) -> Void
  )

  func getNextLives(
    spaceyId: String,
    onCompletion completion: @escaping (Swift.Result<[YDSpaceyComponentNextLive], YDServiceError>) -> Void
  )
}

public extension YDB2WService {
  func getSpacey(
    spaceyId: String,
    customApi: String? = nil,
    onCompletion completion: @escaping (Swift.Result<YDSpacey, YDServiceError>) -> Void
  ) {
    var url = "\(spacey)/spacey-api/publications/app/americanas/hotsite/\(spaceyId)"

    if let customApi = customApi {
      url = "\(customApi)/\(spaceyId)"
    }

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }

      self.service.requestWithoutCache(
        withUrl: url,
        withMethod: .get,
        andParameters: nil
      ) { (response: Swift.Result<YDSpacey, YDServiceError>) in
        completion(response)
      }
    }
  }

  func getNextLives(
    spaceyId: String,
    onCompletion completion: @escaping (Swift.Result<[YDSpaceyComponentNextLive], YDServiceError>) -> Void
  ) {
    let url = "\(spacey)/spacey-api/publication/app/live-schedule/americanas/hotsite/\(spaceyId)"

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }

      self.service.requestWithFullResponse(
        withUrl: url,
        withMethod: .get,
        withHeaders: nil,
        andParameters: nil
      ) { response in
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
          let spaceyStruct = try JSONDecoder().decode(YDSpaceyCommonStruct.self, from: data)
          guard let children = spaceyStruct.component?.children else {
            completion(.failure(YDServiceError.badRequest))
            return
          }

          var list: [YDSpaceyComponentNextLive] = []

          for curr in children {
            if case .nextLive(let nextLive) = curr {
              list.append(nextLive)
            }
          }

          completion(.success(list))

        } catch let error as NSError {
          completion(.failure(YDServiceError(error: error)))
        }
      }
    }
  }
}
