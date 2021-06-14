//
//  TrackingEventsEnum.swift
//  YDIntegration
//
//  Created by Douglas Hennrich on 27/10/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import Foundation

public enum TrackType: String {
  case state
  case action
}

public enum TrackEvents: String {
  // Module Scan
  case scan = "ACOM:LASA-Scan"
  case scanProduct = "ACOM:LASA-Scan:Produto"
  case productDetails = "ACOM:LASA-Scan:Produto:Detalhes"

  // Live
  case pageView = "ACOM:Hotsite:youtube-live"
  case playVideo = "ACOM:Video:Playing"
  case addToCart = "ACOM:LiveCarousel:AddToCart"
  case productSelected = "ACOM:LiveCarousel:ProductSelected"
  case liveOpenChat = "ACOM-live-chataovivo"
  case preLivePageView = "ACOM:Hotsite:aovivo"

  // Next Lives
  case nextLivesPageView = "ACOM:Hotsite:youtube-live:proximas-lives"
  case nextLivesAddToCalendar = "ACOM:Hotsite:youtube-live:proximas-lives:adicionar-calendario"

  // Store Mode
  case storePageView = "ACOM:MODOLOJA-Home"
  case storeOpenBasket = "ModoLoja-Home-VerProdutos"
  case storeOpenBooklet = "O2O-ModoLoja-EncarteDasLojas"
  case storeOnScan = "O2O-ModoLoja-Scan"
  case storeOpenMap = "O2O-Home-Mapa"
  case sendNPS = "StoreModeNps"

  // Find a Store
  case findStoreView = "ACOM:StoreFinder:Mapa"
  case findStoreViewDenied = "ACOM:StoreFinder:SemPermissao"

  // Offline Account
  case offlineAccountPerfil = "ACOM:MODOLOJA-MeuPerfil"
  case offlineAccountUsersInfo = "ACOM:MODOLOJA-DadosAtualizados"
  case offlineAccountModalNonexistent = "ACOM:OfflineAccount:ModalCadastroInexistente"
  case offlineAccountModalIncomplete = "ACOM:OfflineAccount:ModalCadastroIncompleto"
  case offlineAccountModalError = "ACOM:OfflineAccount:ModalErro"
  case offlineAccountHistoric = "ACOM:MODOLOJA-Historico"
  case offlineAccountTerms = "ACOM:MODOLOJA-TermoseCondicoes"

  // Offline Orders
  case offlineOrders = "ACOM:MODOLOJA-MinhasCompras"

  // Default Parameters
  public var defaultParameters: [String: Any] {
    switch self {
      // Scan
      case .scan, .scanProduct, .productDetails:
        return ["tipoPagina": "LASA-Scan"]

      // Live
      case .pageView, .playVideo, .addToCart, .productSelected, .liveOpenChat:
        return [:]

      case .preLivePageView, .nextLivesPageView, .nextLivesAddToCalendar:
        return ["pagetype": "Hotsite"]

      // Store
      case .storePageView, .storeOpenBasket, .storeOpenBooklet, .storeOnScan, .storeOpenMap:
        return ["tipoPagina": "O2O-modoloja"]

      case .sendNPS:
        return [:]

      // Find a Store
      case .findStoreView, .findStoreViewDenied:
        return [:]

      // Offline Account
      case .offlineAccountPerfil, .offlineAccountUsersInfo,
           .offlineAccountModalNonexistent, .offlineAccountModalIncomplete,
           .offlineAccountModalError, .offlineAccountHistoric, .offlineAccountTerms:
        return [:]

      // Offline Orders
      case .offlineOrders:
        return [:]
    }
  }

  public func parameters(body: [String: Any]) -> [String: Any] {
    switch self {
      // Scan
      case .scan, .scanProduct, .productDetails:
        return [:]

      // Live
      case .pageView:
        let videoId = body["videoId"] as? String ?? ""

        return [
          "tipoPagina": "Hotsite",
          "&&pageName": "ACOM:Hotsite:youtube-live",
          "deepLinkUrl": "acom://navigation/hotsite/youtube-live?videoId=\(videoId)&autoplay=true",
          "slugPath": "/hotsite/youtube-live?videoId=\(videoId)&autoplay=true"
        ]

      case .playVideo:
        let videoId = body["videoId"] as? String ?? ""

        return ["videoId": videoId]

      case .addToCart:
        let productId = body["productId"] as? String ?? ""
        let sku = body["productEan"] as? String ?? ""
        let sellerId = body["sellerId"] as? String ?? ""

        return [
          "productId": productId,
          "sku": sku,
          "sellerId": sellerId
        ]

      case .productSelected:
        let productId = body["productId"] as? String ?? ""
        let sku = body["productEan"] as? String ?? ""
        let sellerId = body["sellerId"] as? String ?? ""

        return [
          "productId": productId,
          "sku": sku,
          "sellerId": sellerId
        ]

      case .liveOpenChat:
        return [:]

      case .preLivePageView:
        return [:]

      // Next Lives
      case .nextLivesPageView:
        return [:]

      case .nextLivesAddToCalendar:
        let liveName = body["liveName"] as? String ?? ""

        return [
          "category": "live",
          "action": "agendamento",
          "eventLabel": liveName,
          "pagename": "ACOM:Hotsite:youtube-live:proximas-lives:adicionar-calendario"
        ]

      // Store
      case .storePageView:
        let locationEnable = body["locationEnable"] as? Bool ?? false
        return ["locationEnable": locationEnable]

      case .storeOpenBasket, .storeOpenBooklet, .storeOnScan, .storeOpenMap, .sendNPS:
        return [:]

      // Find a Store
      case .findStoreView, .findStoreViewDenied:
        return [:]

      // Offline Account
      case .offlineAccountPerfil, .offlineAccountUsersInfo,
           .offlineAccountModalNonexistent, .offlineAccountModalIncomplete,
           .offlineAccountModalError, .offlineAccountHistoric, .offlineAccountTerms:
        return [:]

      // Offline Orders
      case .offlineOrders:
        return [:]
    }
  }
}
