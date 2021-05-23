//
//  YDSpaceyComponentNPSQuestionAnswer.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 18/05/21.
//

import Foundation

public class YDSpaceyComponentNPSQuestionAnswer: Decodable {
  // MARK: Properties
  public var id: String?
  public var answerText: String?
  public var selected: Bool = false

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case answerText
  }

  // MARK: Init
  public init(
    id: String? = nil,
    answerText: String? = nil
  ) {
    self.id = id
    self.answerText = answerText
  }
}
