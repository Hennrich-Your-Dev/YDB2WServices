//
//  Service+Products.swift
//  YDB2WServices
//
//  Created by Douglas Hennrich on 15/07/21.
//

import Foundation
import YDB2WModels
import Alamofire
import YDUtilities

public protocol YDB2WServiceProductsDelegate {
  func getProductsFromRESQL(
    eans: [String],
    storeId: String?,
    onCompletion completion: @escaping (Swift.Result<YDProductsRESQL, YDServiceError>) -> Void
  )

  func getProduct(
    ofIds ids: (id: String, sellerId: String),
    onCompletion completion: @escaping (Swift.Result<YDProductFromIdInterface, YDServiceError>) -> Void
  )
}

extension YDB2WService {
  public func getProductsFromRESQL(
    eans: [String],
    storeId: String?,
    onCompletion completion: @escaping (Swift.Result<YDProductsRESQL, YDServiceError>) -> Void
  ) {
    var parameters: [String: String] = [:]

    if let storeId = storeId {
      parameters["store"] = storeId
    }

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }

      var url = "\(self.restQL)/run-query/app/lasa-and-b2w-product-by-ean/\(self.restQLVersion)?"

      eans.forEach { url += "ean=\($0)&" }

      self.service.requestWithFullResponse(
        withUrl: String(url.dropLast()),
        withMethod: .get,
        withHeaders: nil,
        andParameters: parameters
      ) { (response: DataResponse<Data>?) in
        guard let data = response?.data else {
          completion(
            .failure(
              YDServiceError.init(withMessage: "Nenhum dado retornado")
            )
          )
          return
        }

        do {
          guard let json = try JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments
          ) as? [String: Any] else {
            completion(
              .failure(
                YDServiceError.init(withMessage: "Nenhum dado retornado")
              )
            )
            return
          }

          let restQL = YDProductsRESQL(withJson: json)
          completion(.success(restQL))

        } catch {
          completion(
            .failure(
              YDServiceError.init(error: error)
            )
          )
        }
      }
    }
  }

  public func getProduct(
    ofIds ids: (id: String, sellerId: String),
    onCompletion completion: @escaping (Swift.Result<YDProductFromIdInterface, YDServiceError>) -> Void
  ) {
    let parameters = [
      "productIds": ids.id,
      "sellerId": ids.sellerId
    ]

    let url = "\(products)/product_cells_by_ids"

    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }
      self.service.requestWithoutCache(
        withUrl: url,
        withMethod: .get,
        andParameters: parameters
      ) { (result: Swift.Result<[Throwable<YDProductFromIdInterface>], YDServiceError>) in
        switch result {
        case .success(let products):
          if let product = products.compactMap({ try? $0.result.get() }).first {
            completion(.success(product))
          } else {
            completion(.failure(.notFound))
          }

        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}
