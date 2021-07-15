//
//  Service+Invoice.swift
//  YDB2WServices
//
//  Created by Douglas Hennrich on 15/07/21.
//

import Foundation
import YDB2WModels
import YDUtilities

public protocol YDB2WServiceInvoiceDelegate {
  func getInvoicesLinks(
    onCompletion completion: @escaping (Swift.Result<YDInvoices, YDServiceError>) -> Void
  )
}

public extension YDB2WService {
  func getInvoicesLinks(
    onCompletion completion: @escaping (Swift.Result<YDInvoices, YDServiceError>) -> Void
  ) {
    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }

      self.service.request(
        withUrl: self.invoiceService,
        withMethod: .get,
        andParameters: nil
      ) { (result: Swift.Result<[Throwable<YDInvoice>], YDServiceError>) in
        switch result {
        case .success(let invoices):
          completion(.success(invoices.compactMap({ try? $0.result.get() })))

        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}
