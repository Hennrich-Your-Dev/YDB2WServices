//
//  ConfigKeysEnum.swift
//  YDIntegration
//
//  Created by Douglas Hennrich on 27/10/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import Foundation

public enum YDConfigKeys: String {
  case store = "ydevO2O"
  case live = "ydevLive"

  case restQL = "restQLService"
  case chatService = "userChatService"
  case productService = "catalog_service"
  case storeService = "store_service"
  case spaceyService = "spacey_service"
  case addressService = "zip_code_service"
  case lasaClientService = "lasaCustomerPortal"
  case googleService = "youtubeStatisticsApi"
}

public enum YDConfigProperty: String {
  // Search stores
  case maxStoreRange = "acheUmaLojaFeatureNearbyStores"
  case insideLasaDistance = "distanceUserLasaStore"

  // Store Mode
  case npsEnabled
  case npsFeedbackMessage
  case productsQueryVersion = "lasaB2WProductsQueryVersion"

  // Live
  case liveSpaceyOrder = "spaceyPositionIndex"

  case liveCarrouselProductsBatches = "lazyLoadingItems"

  case liveYouTubePlayerAutoStart
  case liveYouTubePlayerResetVideoWhenPaused
  case liveYouTubePlayerEnableFullScreenButton

  case liveHotsiteId = "liveHotsite"
  case liveChatEnabled = "chatEnabled"
  case liveChatLikesEnabled = "chatLikesEnabled"
  case liveChatPolling = "liveChatPolling"
  case liveChatLimit
  case liveChatSendDelay
  case liveChatModerators = "chatModerators"

  case liveYouTubeCounter = "liveAmountPeopleWatching"
  case liveAmountPeopleWatchingPolling

  // Google Services
  case youtubeKey

  // Lasa Client
  case lazyLoadingOrders
}
