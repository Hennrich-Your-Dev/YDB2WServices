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
  private func createNPSList() -> [YDMNPSListConfig] {
    var list: [YDMNPSListConfig] = []

    let starComponent = YDMNPSListConfig(
      uniqueId: "stars",
      title: "Como foi o seu atendimento no caixa?",
      items: nil
    )
    list.append(starComponent)

    let queueQuestion = YDMNPSListConfig(
      uniqueId: "largeHorizontal1",
      title: "Achou o que procurava?",
      items: [
        YDMNPSListConfigItems(value: "Não"),
        YDMNPSListConfigItems(value: "Sim")
      ]
    )
    list.append(queueQuestion)

    //
    let indicateLevel = YDMNPSListConfig(
      uniqueId: "smallHorizontal1",
      title: "O quanto você indicaria a loja que visitou?",
      items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map { YDMNPSListConfigItems(value: "\($0)") }
    )
    list.append(indicateLevel)

    //
    let ratioList = YDMNPSListConfig(
      uniqueId: "ratioList1",
      title: "Conta pra gente o motivo da sua nota?",
      items: [
        YDMNPSListConfigItems(value: "Atendimento no geral"),
        YDMNPSListConfigItems(value: "Ambiente ou organização"),
        YDMNPSListConfigItems(value: "Preços e promoções"),
        YDMNPSListConfigItems(value: "Tempo na fila"),
        YDMNPSListConfigItems(value: "Variedade de produtos"),
        YDMNPSListConfigItems(value: "Pagamento com Ame"),
        YDMNPSListConfigItems(value: "Ações de prevenção contra o Coronavírus")
      ]
    )
    list.append(ratioList)

    //
    let textView = YDMNPSListConfig(
      uniqueId: "textView1",
      title: "",
      items: nil
    )
    list.append(textView)

    return list
  }

  func getNPSList(completion: (([YDMNPSListConfig]) -> Void)?) {
    if let currentStoreNPS = self.currentStoreNPS {
      completion?(currentStoreNPS)

      //
    } else {
      let list = createNPSList()

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
      currentStoreNPS = transformedList
    }
  }
}
