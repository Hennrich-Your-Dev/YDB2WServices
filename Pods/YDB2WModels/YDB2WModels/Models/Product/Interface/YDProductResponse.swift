//
//  YDProductResponse.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 26/03/21.
//

import Foundation

import YDExtensions

public class YDProductResponse: Codable {
  // CodingKeys
  enum CodingKeys: String, CodingKey {
    case offersB2W = "product-b2w"
    case offersLasa = "product-lasa"
  }

  // Properties
  var offersB2W: [YDProduct]
  var offersLasa: [YDProduct]

  // Init from decoder
  required public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    offersB2W = try container.decode(YDProductB2W.self, forKey: .offersB2W).products ?? []
    offersLasa = try container.decode(YDProductLasa.self, forKey: .offersLasa).products ?? []

    for (index, product) in offersLasa.enumerated() {
      guard let currentB2W = offersB2W.at(index) else { continue }

      offersLasa[index].id = currentB2W.id
      offersLasa[index].attributes = currentB2W.attributes
      offersLasa[index].description = currentB2W.description
      offersLasa[index].images = currentB2W.images
      offersLasa[index].name = currentB2W.name
      offersLasa[index].price = product.price ?? currentB2W.price
      offersLasa[index].rating = currentB2W.rating
      offersLasa[index].isAvailable = product.price != nil
    }
  }

  // Init from Json
  public init(withJson json: [String: Any]) {
    offersB2W = []
    offersLasa = []

    // MARK: B2W
    if let b2wResults = (json["product-b2w"] as? [String: Any]) {
      // Test if we can decode as Array<Array>
      if let arrResult = b2wResults["result"] as? [[[String: Any]]?] {
        arrResult.forEach { currOpt in
          if let curr = currOpt?.first,
             let data = try? JSONSerialization.data(withJSONObject: curr),
             let productDecoded = try? JSONDecoder()
              .decode(YDProductB2WResult.self, from: data) {

            if productDecoded.id != nil {
              var price: Double?

              if let offer = productDecoded.offer?.offers?.first {
                price = offer.salesPrice
              }

              offersB2W.append(
                YDProduct(
                  attributes: productDecoded.attributes,
                  description: productDecoded.description,
                  id: productDecoded.id,
                  images: productDecoded.images,
                  name: productDecoded.name,
                  price: price,
                  rating: productDecoded.rating,
                  isAvailable: price != nil
                )
              )

            } else {
              offersB2W.append(YDProduct(empty: true))
            }
            //
          } else {
            offersB2W.append(YDProduct(empty: true))
          }
        }
        // Test if can decode as Array<Obj>
      } else if let objResult = b2wResults["result"] as? [[String: Any]?] {
        if let currOpt = objResult.first,
           let curr = currOpt,
           let data = try? JSONSerialization.data(withJSONObject: curr),
           let productDecoded = try? JSONDecoder()
            .decode(YDProductB2WResult.self, from: data) {

          if productDecoded.id != nil {
            var price: Double?

            if let offer = productDecoded.offer?.offers?.first {
              price = offer.salesPrice
            }

            offersB2W.append(
              YDProduct(
                attributes: productDecoded.attributes,
                description: productDecoded.description,
                id: productDecoded.id,
                images: productDecoded.images,
                name: productDecoded.name,
                price: price,
                rating: productDecoded.rating,
                isAvailable: price != nil
              )
            )

          } else {
            offersB2W.append(YDProduct(empty: true))
          }
          //
        } else {
          offersB2W.append(YDProduct(empty: true))
        }
      }
    }

    // MARK: LASA
    if let lasaResults = (json["product-lasa"] as? [String: Any]) {
      // Test if we can decode as Array<Array>
      if let arrResult = lasaResults["result"] as? [[[String: Any]]?] {
        if arrResult.isEmpty {
          offersLasa.append(YDProduct(empty: true))
        } else {
          arrResult.forEach { currOpt in
            if let curr = currOpt?.first,
               let data = try? JSONSerialization.data(withJSONObject: curr),
               let productDecoded = try? JSONDecoder()
                .decode(YDProductLasaResult.self, from: data) {
              offersLasa.append(
                YDProduct(
                  description: productDecoded.descricao,
                  price: productDecoded.preco?.formattedNumberAsDouble,
                  isAvailable: true
                )
              )
              //
            } else {
              offersLasa.append(YDProduct(empty: true))
            }
          }
        }
        // Test if can decode as Array<Obj>
      } else if let objResult = lasaResults["result"] as? [[String: Any]?] {
        if objResult.isEmpty {
          offersLasa.append(YDProduct(empty: true))
          //
        } else {
          for currOpt in objResult {
            if let curr = currOpt,
               let data = try? JSONSerialization.data(withJSONObject: curr),
               let productDecoded = try? JSONDecoder()
                .decode(YDProductLasaResult.self, from: data) {
              offersLasa.append(
                YDProduct(
                  description: productDecoded.descricao,
                  price: productDecoded.preco?.formattedNumberAsDouble,
                  isAvailable: true
                )
              )
            } else {
              offersLasa.append(YDProduct(empty: true))
            }
          }
        }

        //
      } else {
        for _ in offersB2W {
          offersLasa.append(YDProduct(empty: true))
        }
      }

    }

    //
    for (index, product) in offersLasa.enumerated() {
      guard let currentB2W = offersB2W.at(index) else { continue }

      offersLasa[index].id = currentB2W.id
      offersLasa[index].attributes = currentB2W.attributes
      offersLasa[index].description = currentB2W.description
      offersLasa[index].images = currentB2W.images
      offersLasa[index].name = currentB2W.name
      offersLasa[index].price = product.price ?? currentB2W.price
      offersLasa[index].rating = currentB2W.rating
      offersLasa[index].isAvailable = product.price != nil
    }
  }
}
