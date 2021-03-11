//
//  FileManipulation.swift
//  YDUtilities
//
//  Created by Douglas Hennrich on 02/02/21.
//

import UIKit

public func getLocalFile(_ bundle: Bundle, fileName: String, fileType: String) -> Data? {
  if let path = bundle.path(forResource: fileName, ofType: fileType) {
    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      return data
    } catch let error {
      debugPrint("parseError: \(error.localizedDescription)")
    }
  }
  return nil
}
