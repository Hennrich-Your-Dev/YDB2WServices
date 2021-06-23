//
//  YDSpaceyComponentNPSQuestion.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 18/05/21.
//

import Foundation

public class YDSpaceyComponentNPSQuestion: YDSpaceyComponentDelegate {
  // MARK: Enum
  public enum AnswerTypeEnum: String, Decodable {
    case star = "estrela"
    case option = "opção"
    case grade = "nota"
    case multiple = "múltipla escolha"
    case textView
  }

  // MARK: Properties
  public var id: String?
  public var type: YDSpaceyComponentsTypes.Types
  public var children: [YDSpaceyComponentsTypes] = []
  public var childrenAnswers: [YDSpaceyComponentNPSQuestionAnswer]
  public var answerType: YDSpaceyComponentNPSQuestion.AnswerTypeEnum
  public var maxScore: Int?
  public var maxStars: Int?
  public var question: String?
  public var title: String?
  public var hint: String?
  public var maxCharacter: Int?

  public var storedValue: Any?

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case type
    case children
    case childrenAnswers
    case answerType
    case maxScore
    case maxStars
    case question
    case title
    case hint
    case maxCharacter
  }

  // MARK: Init
  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    id = try? container.decode(String.self, forKey: .id)
    type = try container.decode(YDSpaceyComponentsTypes.Types.self, forKey: .type)

    answerType = try container
      .decodeIfPresent(
        YDSpaceyComponentNPSQuestion.AnswerTypeEnum.self,
        forKey: .answerType
      ) ?? .textView

    let throwables = try? container.decode(
      [Throwable<YDSpaceyComponentNPSQuestionAnswer>].self,
      forKey: .children
    )
    childrenAnswers = throwables?.compactMap { try? $0.result.get() } ?? []

    maxScore = try? container.decode(Int.self, forKey: .maxScore)
    maxStars = try? container.decode(Int.self, forKey: .maxStars)
    question = try? container.decode(String.self, forKey: .question)
    title = try? container.decode(String.self, forKey: .title)
    hint = try? container.decode(String.self, forKey: .hint)
    maxCharacter = try? container.decode(Int.self, forKey: .maxCharacter)

    if answerType == .grade {
      for index in 1...(maxScore ?? 0) {
        childrenAnswers.append(
          YDSpaceyComponentNPSQuestionAnswer(id: "\(index)", answerText: "\(index)")
        )
      }
    }
  }
}
