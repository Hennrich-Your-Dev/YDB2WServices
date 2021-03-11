//
//  Connectivity.swift
//  YDUtilities
//
//  Created by Douglas Hennrich on 22/11/20.
//

import Foundation
import Alamofire

public class Connectivity {
  public class func isConnectedToInternet() -> Bool {
    return NetworkReachabilityManager()?.isReachable ?? false
  }
}
