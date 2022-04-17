//
//  CityWorker.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 17/4/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CityStoreProtocol {
  func getCity(_ completion: @escaping (Result<[City]>) -> Void)
}

class CityWorker {

  var store: CityStoreProtocol

  init(store: CityStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic

  func getCity(_ completion: @escaping (Result<[City]>) -> Void) {
    store.getCity { result in
      completion(result)
    }
  }
}
