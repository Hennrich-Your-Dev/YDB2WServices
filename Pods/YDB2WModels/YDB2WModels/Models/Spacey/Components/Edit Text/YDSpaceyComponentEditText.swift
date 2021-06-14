//
//  YDSpaceyComponentEditText.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 18/05/21.
//

import Foundation

public class YDSpaceyComponentEditText: Decodable {
  // MARK: Properties
  public let id: String
  public var hint: String?
  public var maxCharacter: Int?
  public var title: String?
  public let componentType: YDSpaceyComponentsTypes.Types = .npsEditText
  public var storedValue: String? = nil

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case hint
    case maxCharacter
    case title
  }

  // MARK: Init
  public init(
    id: String,
    hint: String?,
    maxCharacter: Int? = 150,
    title: String? = nil
  ) {
    self.id = id
    self.hint = hint
    self.maxCharacter = maxCharacter
    self.title = title
  }
}
