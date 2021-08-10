//
//  YDQuizInterface.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 10/08/21.
//

import Foundation

public class YDQuizzesInterface: Codable {
  public let socialSecurity: String
  public let quizzes: [YDQuizInterface]
  
  enum CodingKeys: String, CodingKey {
    case socialSecurity = "cpf"
    case quizzes = "perguntas"
  }
}

public class YDQuizInterface: Codable {
  public var question: String
  public var choices: [YDQuizChoiceInterface]
  
  enum CodingKeys: String, CodingKey {
    case question
    case choices = "answer"
  }
}

public class YDQuizChoiceInterface: Codable {
  public var value: String
  public var correct: Bool
}
