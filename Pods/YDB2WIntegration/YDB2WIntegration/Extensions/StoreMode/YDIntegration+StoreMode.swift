//
//  YDIntegration+StoreMode.swift
//  YDB2WIntegration
//
//  Created by Douglas Hennrich on 08/12/20.
//

import Foundation

// MARK: Open store module
public extension YDIntegrationHelper {
  func openStoreMode() {
    presentationDelegate?.presentStoreMode()
  }
}

// MARK: On product discount
public extension YDIntegrationHelper {
  func activateDiscount(offerId: String, completion: ((Bool) -> Void)?) {
    actionDelegate?.activateDiscount(offerId: offerId, completion: completion)
  }
}

// MARK: Get NPS config list
public extension YDIntegrationHelper {
  func getNPSList(completion: (([YDMNPSListConfig]) -> Void)?) {
    if let currentStoreNPS = self.currentStoreNPS {
      completion?(currentStoreNPS)
    } else {
      actionDelegate?.getNPSList { [weak self] list in
        var transformedList: [YDMNPSListConfig] = []

        for (index, curr) in list.enumerated() {
          switch index {
          case 0:
            curr.type = .stars

          case 1:
            curr.type = .largeHorizontal

          case 2:
            curr.type = .smallHorizontal

          case 3:
            curr.type = .ratioList

          case 4:
            curr.type = .textField

          default:
            break
          }

          transformedList.append(curr)
        }

        completion?(transformedList)
        self?.currentStoreNPS = transformedList
      }
    }
  }
}
