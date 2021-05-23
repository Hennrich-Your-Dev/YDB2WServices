//
//  Service+Live.swift
//  YDB2WServices
//
//  Created by Douglas Hennrich on 22/05/21.
//

import Foundation

import YDB2WModels

// Delegate
public protocol YDB2WServiceLiveDelegate {
  func getYouTubeDetails(
    withVideoId videoId: String,
    onCompletion: @escaping (Swift.Result<YDYouTubeDetails, YDServiceError>) -> Void
  )
}

public extension YDB2WService {
  func getYouTubeDetails(
    withVideoId videoId: String,
    onCompletion: @escaping (Result<YDYouTubeDetails, YDServiceError>) -> Void
  ) {
    let params = [
      "key": youTubeKey,
      "id": videoId
    ]

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }

      self.service.requestWithoutCache(
        withUrl: self.youTubeAPI,
        withMethod: .get,
        andParameters: params
      ) { (result: Result<YDYouTubeDetails, YDServiceError>) in
        switch result {
        case .success(let youtubeDetails):
          onCompletion(.success(youtubeDetails))

        case .failure(let error):
          onCompletion(.failure(error))
        }
      }
    }
  }
}
