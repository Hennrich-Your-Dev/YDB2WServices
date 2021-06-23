//
//  YDSpaceyComponentGrid.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 10/05/21.
//

import Foundation

public class YDSpaceyComponentGrid: YDSpaceyComponentDelegate {
  // MARK: Properties
  public var id: String?
  public var type: YDSpaceyComponentsTypes.Types
  public var children: [YDSpaceyComponentsTypes]
  private var xs: String?
  private var size: YDSpaceyComponentGridSize?

  // MARK: Computed variables
  // usar as opções “xs” e “size” para definir a quantidade de colunas: se a opção
  // “xs” for iqual a um numero inteiro, a quantidade de colunas vai ser igual
  // a esse número, se for “padrão” ou diferente de um número, devemos
  // colocar a quantidade de elementos da coluna de acordo com a opção “size”
  // (“Pequeno” = 4; “Médio” = 3; “Grande” = 2; “Gigante”
  // ou qualquer outro dado = 1).
  public var numberOfColumns: Int? {
    var columns: Int? = 1

    if let xs = self.xs,
       xs != "Padrão" {
      columns = Int(xs)
    } else if let size = size {
      columns = Int(size.rawValue)
    }

    return columns
  }

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case type
    case children
    case xs
    case size
  }

  // MARK: Init
  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try? container.decode(String.self, forKey: .id)

    type = try container.decode(YDSpaceyComponentsTypes.Types.self, forKey: .type)

    let throwables = try? container.decode(
      [Throwable<YDSpaceyComponentsTypes>].self,
      forKey: .children
    )
    children = throwables?.compactMap { try? $0.result.get() } ?? []

    xs = try? container.decode(String.self, forKey: .xs)
    size = try? container.decode(YDSpaceyComponentGridSize.self, forKey: .size)
    size = size ?? .giant
  }
}

// MARK: Grid Size
enum YDSpaceyComponentGridSize: String, Decodable {
  case giant = "1"
  case great = "2"
  case medium = "3"
  case small = "4"
}
