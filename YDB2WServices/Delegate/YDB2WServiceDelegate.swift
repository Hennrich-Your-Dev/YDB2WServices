//
//  YDB2WServiceDelegate.swift
//  YDB2WServices
//
//  Created by Douglas Hennrich on 11/03/21.
//

import Foundation
import CoreLocation

import Alamofire
import YDB2WModels

public protocol YDB2WServiceDelegate:
  YDB2WServiceAddressDelegate,
  YDB2WServiceChatDelegate,
  YDB2WServiceInvoiceDelegate,
  YDB2WServiceLasaClientDelegate,
  YDB2WServiceLiveDelegate,
  YDB2WServiceSpaceyDelegate,
  YDB2WServiceStoresDelegate,
  YDB2WServiceProductsDelegate {}
