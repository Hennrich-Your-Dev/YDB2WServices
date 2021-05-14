//
//  YDSpaceyComponentPlayer.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 14/04/21.
//

import Foundation

public class YDSpaceyComponentPlayer: Codable {
  public let id: String
  public let url: String
  public let componentType: YDSpaceyComponentsTypes.Types = .player

  // Computed variables
  public var videoId: String? {
    let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"

    let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    let range = NSRange(location: 0, length: url.count)

    guard let result = regex?.firstMatch(in: url, range: range) else {
      return nil
    }

    return (url as NSString).substring(with: result.range)
  }

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case url = "videoURL"
  }
}
