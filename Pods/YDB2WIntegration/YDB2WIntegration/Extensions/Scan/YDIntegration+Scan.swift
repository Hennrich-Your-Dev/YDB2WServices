//
//  YDIntegration+Scan.swift
//  YDB2WIntegration
//
//  Created by Douglas Hennrich on 08/12/20.
//

import Foundation

// MARK: Open scan module
public extension YDIntegrationHelper {
  func openScanModule() {
    presentationDelegate?.presentScanner()
  }
}
