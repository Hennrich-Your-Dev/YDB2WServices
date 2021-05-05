//
//  YDYouTubeDetails.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 05/05/21.
//

import Foundation

public class YDYouTubeDetails: Decodable {
  private let items: [YDYouTubeDetailsItem]

  public var currentViewers: String? {
    return items.first?.details?.viewers
  }
}

public struct YDYouTubeDetailsItem: Decodable {
  public let id: String

  public let details: YDYouTubeDetailsItemDetails?

  enum CodingKeys: String, CodingKey {
    case id
    case details = "liveStreamingDetails"
  }
}

public struct YDYouTubeDetailsItemDetails: Decodable {
  public let viewers: String?

  enum CodingKeys: String, CodingKey {
    case viewers = "concurrentViewers"
  }
}
