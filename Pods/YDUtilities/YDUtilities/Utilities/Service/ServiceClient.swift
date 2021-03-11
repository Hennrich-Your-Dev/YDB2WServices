//
//  ServiceClient.swift
//  YDUtilities
//
//  Created by Douglas Hennrich on 09/12/20.
//

import Foundation
import Alamofire

// MARK: Protocol
public protocol YDServiceClientDelegate: AnyObject {
  // default
  func request<T: Decodable>(
    withUrl: String,
    withMethod: HTTPMethod,
    andParameters: Parameters?,
    onCompletion: @escaping ((Swift.Result<T, YDServiceError>) -> Void)
  )

  // with headers
  func request<T: Decodable>(
    withUrl: String,
    withMethod: HTTPMethod,
    withHeaders: HTTPHeaders?,
    andParameters: Parameters?,
    onCompletion: @escaping ((Swift.Result<T, YDServiceError>) -> Void)
  )

  // with custom decoder
  func request<T: Decodable>(
    withUrl: String,
    withMethod: HTTPMethod,
    andParameters: Parameters?,
    customDecoder: JSONDecoder,
    onCompletion: @escaping ((Swift.Result<T, YDServiceError>) -> Void)
  )

  // with full response
  func requestWithFullResponse(
    withUrl: String,
    withMethod: HTTPMethod,
    withHeaders: HTTPHeaders?,
    andParameters: Parameters?,
    onCompletion: @escaping ((DataResponse<Data>?) -> Void)
  )

  // without caching request
  func requestWithoutCache<T: Decodable>(
    withUrl: String,
    withMethod: HTTPMethod,
    andParameters: Parameters?,
    onCompletion: @escaping ((Swift.Result<T, YDServiceError>) -> Void)
  )
}

// MARK: API
public class YDServiceClient {
  // MARK: Properties
  lazy var logger = Logger.forClass(Self.self)
  let httpRequest: SessionManager

  // MARK: Init
  public init() {
    let config = URLSessionConfiguration.default
    config.timeoutIntervalForRequest = 10

    httpRequest = Alamofire.SessionManager(configuration: config)
  }

  // MARK: Actions
  func buildUrl(
    url urlString: String,
    method: HTTPMethod,
    headers: HTTPHeaders? = nil,
    parameters: Parameters?
  ) throws -> URLRequestConvertible {

    let url = try urlString.asURL()

    var urlRequest = URLRequest(url: url)

    // Http method
    urlRequest.httpMethod = method.rawValue

    // Header
    if let headers = headers {
      headers.forEach { element in urlRequest.setValue(element.value, forHTTPHeaderField: element.key) }
    }

    //Encoding
    let encoding: ParameterEncoding = {
      switch method {
      case .get:
        return URLEncoding.default
      default:
        return JSONEncoding.default
      }
    }()

    return try encoding.encode(urlRequest, with: parameters)
  }
}

// MARK: Extend protocol
extension YDServiceClient: YDServiceClientDelegate {
  // MARK: Default
  public func request<T: Decodable> (
    withUrl: String,
    withMethod: HTTPMethod = .get,
    andParameters: Parameters? = nil,
    onCompletion: @escaping ((Swift.Result<T, YDServiceError>) -> Void)
  ) {
    var parametersDictionary: Parameters = [:]

    if let parameters = andParameters {
      parametersDictionary = parametersDictionary.merging(parameters) { _, new in new }
    }

    let withParameters: Parameters = parametersDictionary

    guard let urlRequestConvirtable = try? self.buildUrl(
            url: withUrl,
            method: withMethod,
            parameters: withParameters)
    else {
      return onCompletion(.failure(YDServiceError.cantCreateUrl))
    }

    //
    httpRequest.request(urlRequestConvirtable)
      .validate()
      .responseJSON { [weak self] response in
        switch response.result {
        case .success:
          guard let data = response.data else {
            return onCompletion(.failure(YDServiceError.badRequest))
          }

          do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return onCompletion(.success(result))
          } catch let errorCatch as NSError {
            self?.logger.error(errorCatch.debugDescription)
            return onCompletion(
              .failure(
                YDServiceError.unknow(
                  (errorCatch.debugDescription, nil))
              )
            )
          }

        case .failure(let error):
          return onCompletion(
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

  // MARK: With Headers
  public func request<T: Decodable> (
    withUrl: String,
    withMethod: HTTPMethod = .get,
    withHeaders: HTTPHeaders? = nil,
    andParameters: Parameters? = nil,
    onCompletion: @escaping ((Swift.Result<T, YDServiceError>) -> Void)
  ) {
    var parametersDictionary: Parameters = [:]

    if let parameters = andParameters {
      parametersDictionary = parametersDictionary.merging(parameters) { _, new in new }
    }

    let withParameters: Parameters = parametersDictionary

    guard let urlRequestConvirtable = try? self.buildUrl(
            url: withUrl,
            method: withMethod,
            headers: withHeaders,
            parameters: withParameters)
    else {
      return onCompletion(.failure(YDServiceError.cantCreateUrl))
    }

    //
    httpRequest.request(urlRequestConvirtable)
      .validate()
      .responseJSON { [weak self] response in
        switch response.result {
        case .success:
          guard let data = response.data else {
            return onCompletion(.failure(YDServiceError.badRequest))
          }

          do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return onCompletion(.success(result))
          } catch let errorCatch as NSError {
            self?.logger.error(errorCatch.debugDescription)
            return onCompletion(
              .failure(
                YDServiceError.unknow(
                  (errorCatch.debugDescription, nil))
              )
            )
          }

        case .failure(let error):
          return onCompletion(
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

  // MARK: With full response
  public func requestWithFullResponse(
    withUrl: String,
    withMethod: HTTPMethod = .get,
    withHeaders: HTTPHeaders? = nil,
    andParameters: Parameters? = nil,
    onCompletion: @escaping ((DataResponse<Data>?) -> Void)
  ) {
    var parametersDictionary: Parameters = [:]

    if let parameters = andParameters {
      parametersDictionary = parametersDictionary.merging(parameters) { _, new in new }
    }

    let withParameters: Parameters = parametersDictionary

    guard let urlRequestConvirtable = try? self.buildUrl(
            url: withUrl,
            method: withMethod,
            headers: withHeaders,
            parameters: withParameters)
    else {
      return onCompletion(nil)
    }

    //
    httpRequest.request(urlRequestConvirtable)
      .validate()
      .responseData { response in
        onCompletion(response)
      }
  }

  // MARK: With Custom Decoder
  public func request<T: Decodable>(
    withUrl: String,
    withMethod: HTTPMethod,
    andParameters: Parameters?,
    customDecoder: JSONDecoder,
    onCompletion: @escaping ((Swift.Result<T, YDServiceError>) -> Void)
  ) {
    var parametersDictionary: Parameters = [:]

    if let parameters = andParameters {
      parametersDictionary = parametersDictionary.merging(parameters) { _, new in new }
    }

    let withParameters: Parameters = parametersDictionary

    guard let urlRequestConvirtable = try? self.buildUrl(
            url: withUrl,
            method: withMethod,
            parameters: withParameters)
    else {
      return onCompletion(.failure(YDServiceError.cantCreateUrl))
    }

    //
    httpRequest.request(urlRequestConvirtable)
      .validate()
      .responseJSON { [weak self] response in
        switch response.result {
        case .success:
          guard let data = response.data else {
            return onCompletion(.failure(YDServiceError.badRequest))
          }

          do {
            let result = try customDecoder.decode(T.self, from: data)
            return onCompletion(.success(result))
          } catch let errorCatch as NSError {
            self?.logger.error(errorCatch.debugDescription)
            return onCompletion(
              .failure(
                YDServiceError.unknow(
                  (errorCatch.debugDescription, nil))
              )
            )
          }

        case .failure(let error):
          return onCompletion(
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

  // MARK: Without cache request
  public func requestWithoutCache<T: Decodable> (
    withUrl: String,
    withMethod: HTTPMethod = .get,
    andParameters: Parameters? = nil,
    onCompletion: @escaping ((Swift.Result<T, YDServiceError>) -> Void)
  ) {
    var parametersDictionary: Parameters = [:]

    if let parameters = andParameters {
      parametersDictionary = parametersDictionary.merging(parameters) { _, new in new }
    }

    let withParameters: Parameters = parametersDictionary

    //
    httpRequest.requestWithoutCache(
      withUrl,
      method: .get,
      parameters: withParameters,
      encoding: URLEncoding.default
    )
      .validate()
      .responseJSON { [weak self] response in
        switch response.result {
        case .success:
          guard let data = response.data else {
            return onCompletion(.failure(YDServiceError.badRequest))
          }

          do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return onCompletion(.success(result))
          } catch let errorCatch as NSError {
            self?.logger.error(errorCatch.debugDescription)
            return onCompletion(
              .failure(
                YDServiceError.unknow(
                  (errorCatch.debugDescription, nil))
              )
            )
          }

        case .failure(let error):
          return onCompletion(
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

// MARK: Extend Alamofire Session Manager
extension Alamofire.SessionManager {
  @discardableResult
  open func requestWithoutCache(
    _ url: URLConvertible,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil,
    encoding: ParameterEncoding = URLEncoding.default,
    headers: HTTPHeaders? = nil) // also you can add URLRequest.CachePolicy here as parameter
  -> DataRequest
  {
    do {
      var urlRequest = try URLRequest(url: url, method: method, headers: headers)
      urlRequest.cachePolicy = .reloadIgnoringCacheData // <<== Cache disabled
      let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
      return request(encodedURLRequest)
    } catch {
      // TODO: find a better way to handle error
      print(error)
      return request(URLRequest(url: URL(string: "http://example.com/wrong_request")!))
    }
  }
}
