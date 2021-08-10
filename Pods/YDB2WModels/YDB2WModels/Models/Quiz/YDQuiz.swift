//
//  YDQuiz.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 28/06/21.
//

import Foundation

public enum YDQuizType {
  case choices
  case socialSecurity
  case confirmView
}

public class YDQuiz: Codable {
  // MARK: Properties
  public var title: String?
  public var choices: [YDQuizChoice]
  public var answer: String?

  // MARK: Computed variables
  public var type: YDQuizType = .choices
  public var storedValue: String?

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case title
    case choices = "children"
  }

  // MARK: Init
  public init(
    title: String?,
    choices: [YDQuizChoice],
    answer: String?,
    type: YDQuizType = .choices
  ) {
    self.title = title
    self.choices = choices
    self.answer = answer
    self.type = type
  }
}

public class YDQuizChoice: Codable {
  public var title: String?
  public var selected = false

  public init(title: String?) {
    self.title = title
  }
}
