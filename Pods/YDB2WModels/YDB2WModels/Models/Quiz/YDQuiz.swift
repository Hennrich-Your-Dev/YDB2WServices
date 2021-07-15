//
//  YDQuiz.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 28/06/21.
//

import Foundation

public enum YDQuizType {
  case choices
  case unknow
}

public class YDQuiz: Codable {
  // MARK: Properties
  public var id: String?
  public var title: String?
  public var choices: [YDQuizChoice]

  // MARK: Computed variables
  public var type: YDQuizType = .choices
  public var storedValue: Any?

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case title
    case choices = "children"
  }

  // MARK: Init
  public init(
    id: String?,
    title: String?,
    choices: [YDQuizChoice],
    type: YDQuizType = .choices
  ) {
    self.id = id
    self.title = title
    self.choices = choices
    self.type = type
  }
}

public class YDQuizChoice: Codable {
  public var id: String?
  public var title: String?

  public var selected = false

  public init(id: String?, title: String?) {
    self.id = id
    self.title = title
  }
}
