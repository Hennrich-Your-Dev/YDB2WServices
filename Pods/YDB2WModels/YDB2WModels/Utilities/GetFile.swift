//
//  GetFile.swift
//  YDB2WModels
//
//  Created by Douglas Hennrich on 23/06/21.
//

import Foundation

func getLocalFile(_ bundle: Bundle, fileName: String, fileType: String) -> Data? {
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
