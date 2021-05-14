//
//  Service+Spacey.swift
//  YDB2WServices
//
//  Created by Douglas Hennrich on 14/05/21.
//

import Foundation

import Alamofire
import YDB2WModels

public extension YDB2WService {
  func getSpacey(
    spaceyId: String,
    onCompletion completion: @escaping (Swift.Result<YDSpacey, YDServiceError>) -> Void
  ) {
    let url = "\(spacey)/spacey-api/publications/app/americanas/hotsite/\(spaceyId)"

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
    onCompletion completion: @escaping (DataResponse<Data>?) -> Void
  ) {
    let url = "\(spacey)/spacey-api/publications/app/americanas/hotsite/\(spaceyId)"

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }

      self.service.requestWithFullResponse(
        withUrl: url,
        withMethod: .get,
        withHeaders: nil,
        andParameters: nil
      ) { response in
        completion(response)
      }
    }
  }
}
