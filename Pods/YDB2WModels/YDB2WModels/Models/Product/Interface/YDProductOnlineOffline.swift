//
//  YDProductOnlineOffline.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 26/03/21.
//

import Foundation

public class YDProductOnlineOffline: Codable {
  public var online: YDProduct?
  public var offline: YDProduct?

  public init(online: YDProduct?, offline: YDProduct?) {
    self.online = online
    self.offline = offline
  }
}
