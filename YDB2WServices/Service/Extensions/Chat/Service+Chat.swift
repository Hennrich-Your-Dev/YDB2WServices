//
//  Service+Chat.swift
//  YDB2WServices
//
//  Created by Douglas Hennrich on 05/05/21.
//

import Foundation

import YDB2WModels

// Delegate
public protocol YDB2WServiceChatDelegate {
  func sendMessage(
    _ message: YDChatMessage,
    accessToken: String,
    onCompletion: @escaping (Swift.Result<String, YDServiceError>) -> Void
  )

  func getMessages(
    withChatId chatId: String,
    accessToken: String,
    limit: Int,
    lastMessageId: String?,
    onCompletion: @escaping (Swift.Result<YDChatMessagesList, YDServiceError>) -> Void
  )

  func sendLike(userId: String, onCompletion: @escaping (Swift.Result<Bool, YDServiceError>) -> Void)

  func deleteMessage(
    messageId: String,
    onCompletion: @escaping(Swift.Result<Void, YDServiceError>) -> Void
  )

  func getDeletedMessages(
    withChatId chatId: String,
    onCompletion: @escaping (Swift.Result<YDChatDeletedMessages, YDServiceError>) -> Void
  )

  func banUserFromChat(
    _ userId: String,
    ofLive liveId: String,
    onCompletion: @escaping(Swift.Result<Void, YDServiceError>) -> Void
  )
}

public extension YDB2WService {
  // MARK: Send Message
  func sendMessage(
    _ message: YDChatMessage,
    accessToken: String,
    onCompletion: @escaping (Swift.Result<String, YDServiceError>) -> Void
  ) {
    guard let json = try? message.asDictionary()
    else {
      onCompletion(.failure(YDServiceError.badRequest))
      return
    }

    let header: [String: String] = [
      "Access-Token": accessToken,
      "Content-Type": "application/json"
    ]

    let url = "\(chatService)/message"

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }
      self.service.requestWithFullResponse(
        withUrl: url,
        withMethod: .post,
        withHeaders: header,
        andParameters: json
      ) { response in
        guard let response = response else {
          onCompletion(.failure(YDServiceError.internalServerError))
          return
        }
        switch response.result {
          case .success:
            if let id = response.response?.allHeaderFields["Location"] as? String {
              onCompletion(.success(id))
            } else {
              onCompletion(.failure(YDServiceError.internalServerError))
            }

          case .failure(let error):
            if let status = response.response?.statusCode,
               status == 401,
               let data = response.data,
               let json = try? JSONSerialization.jsonObject(
                with: data,
                options: .allowFragments
               ) as? [String: Any],
               let message = json["message"] as? String,
               message == "banned user" {

              onCompletion(
                .failure(
                  YDServiceError.blockedUser
                )
              )
              return
            }
            onCompletion(
              .failure(
                YDServiceError(
                  error: error,
                  status: response.response?.statusCode
                )
              )
            )
        }
      }
    }
  }

  // MARK: Get Messages
  func getMessages(
    withChatId chatId: String,
    accessToken: String,
    limit: Int = 10,
    lastMessageId: String?,
    onCompletion: @escaping (Swift.Result<YDChatMessagesList, YDServiceError>) -> Void
  ) {
    let header: [String: String] = [
      "Access-Token": accessToken
    ]

    var parameters: [String: Any] = [
      "limit": limit
    ]

    if let lastId = lastMessageId {
      parameters["lastMessage"] = lastId
    }

    let url = "\(chatService)/message/live/\(chatId)"

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }
      self.service.request(
        withUrl: url,
        withMethod: .get,
        withHeaders: header,
        andParameters: parameters
      ) { (result: Swift.Result<YDChatMessagesListInterface, YDServiceError>) in
        switch result {
          case .success(let interface):
            onCompletion(.success(interface.resource))

          case .failure(let error):
            onCompletion(.failure(error))
        }
      }
    }
  }

  // MARK: Send Like
  func sendLike(
    userId: String,
    onCompletion: @escaping (Swift.Result<Bool, YDServiceError>) -> Void
  ) {
    let url = "\(chatService)/message/live/\(userId)"

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }
      self.service.request(
        withUrl: url,
        withMethod: .post,
        andParameters: nil
      ) { (result: Swift.Result<Bool, YDServiceError>) in
        //
        switch result {
          case .success:
            onCompletion(.success(true))

          case .failure(let error):
            onCompletion(.failure(error))
        }
      }
    }
  }

  // MARK: Delete message
  func deleteMessage(
    messageId: String,
    onCompletion: @escaping(Swift.Result<Void, YDServiceError>) -> Void
  ) {
    let url = "\(chatService)/message/\(messageId)"

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }
      self.service.requestWithFullResponse(
        withUrl: url,
        withMethod: .delete,
        withHeaders: nil,
        andParameters: nil
      ) { response in
        guard let result = response?.result
        else {
          onCompletion(.failure(YDServiceError.badRequest))
          return
        }

        //
        switch result {
          case .success:
            onCompletion(.success(()))

          case .failure(let error):
            onCompletion(.failure(YDServiceError.init(error: error)))
        }
      }
    }
  }

  func getDeletedMessages(
    withChatId chatId: String,
    onCompletion: @escaping (Swift.Result<YDChatDeletedMessages, YDServiceError>) -> Void
  ) {
    let parameters: [String: Any] = [
      "sortBy": "asc"
    ]

    let url = "\(chatService)/message/live/\(chatId)/deleted"

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }
      self.service.request(
        withUrl: url,
        withMethod: .get,
        andParameters: parameters
      ) { (result: Swift.Result<YDChatDeletedMessages, YDServiceError>) in
        switch result {
          case .success(let interface):
            onCompletion(.success(interface))

          case .failure(let error):
            onCompletion(.failure(error))
        }
      }
    }
  }

  func banUserFromChat(
    _ userId: String,
    ofLive liveId: String,
    onCompletion: @escaping(Swift.Result<Void, YDServiceError>) -> Void
  ) {
    guard let resource = try? YDChatMessageResource(id: liveId).asDictionary()
    else {
      return
    }

    let url = "\(chatService)/customer/\(userId)/ban"

    let parameters: [String: Any] = [
      "resource": resource
    ]

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }
      self.service.requestWithFullResponse(
        withUrl: url,
        withMethod: .post,
        withHeaders: nil,
        andParameters: parameters
      ) { response in
        guard let result = response?.result
        else {
          onCompletion(.failure(YDServiceError.badRequest))
          return
        }

        //
        switch result {
          case .success:
            onCompletion(.success(()))

          case .failure(let error):
            onCompletion(.failure(YDServiceError.init(error: error)))
        }
      }
    }
  }
}
