//
//  YDProductLasa.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 26/03/21.
//

import Foundation

public class YDProductLasa: Codable {
  private var results: [YDProductLasaResult]
  public var products: [YDProduct]?

  // CodingKeys
  enum CodingKeys: String, CodingKey {
    case results = "result"
  }

  //
  required public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    results = []

    if let throwablesMoreProducts = try? container.decode(
      [[Throwable<YDProductLasaResult>]].self,
      forKey: .results
    ) {
      throwablesMoreProducts.forEach {
        switch $0.first?.result {
          case .success(let result):
            results.append(result)

          case .failure:
            results.append(YDProductLasaResult.empty())
          case .none:
            break
        }
      }
    } else if let throwablesOneProduct = try? container.decode(
      [Throwable<YDProductLasaResult>].self,
      forKey: .results
    ) {
      throwablesOneProduct.forEach {
        switch $0.result {
          case .success(let result):
            results.append(result)

          case .failure:
            results.append(YDProductLasaResult.empty())
        }
      }
    }

    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.locale = Locale(identifier: "pt_BR")

    products = results.enumerated().map { (index, result) in
      if result.isEmpty {
        return YDProduct(
          attributes: nil,
          description: nil,
          id: nil,
          images: nil,
          name: nil,
          price: nil,
          rating: nil
        )

      } else {
        return YDProduct(
          attributes: nil,
          description: result.descricao,
          id: nil,
          images: nil,
          name: nil,
          price: formatter.number(from: result.preco ?? "")?.doubleValue,
          rating: nil
        )
      }
    }
  }
}

public class YDProductLasaResult: Codable {
  public let descricao: String?
  public let preco: String?
  public var isEmpty: Bool = false

  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    descricao = try? container.decode(String.self, forKey: .descricao)
    preco = try? container.decode(String.self, forKey: .preco)
  }

  public init() {
    self.descricao = nil
    self.preco = nil
    self.isEmpty = true
  }

  enum CodingKeys: CodingKey {
    case descricao
    case preco
  }

  public static func empty() -> YDProductLasaResult {
    return YDProductLasaResult()
  }
}
