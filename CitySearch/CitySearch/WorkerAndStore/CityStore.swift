//
//  CityStore.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 17/4/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class CityStore: CityStoreProtocol {
  
  func getCity(_ completion: @escaping (Result<[City]>) -> Void) {
    let cities = "cities"
    if let data = readJSONFile(resource: cities) {
      do {
        let response = try JSONDecoder().decode([City].self, from: data)
        completion(.success(result: response))
      } catch {
        completion(.failure(error: .invalidJSON))
      }
    }
  }
  
  private func readJSONFile(resource: String) -> Data? {
    do {
      if let bundlePath = Bundle.main.path(forResource: resource, ofType: "json"),
         let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
        return jsonData
      }
    } catch {
      return nil
    }
    return nil
  }
}
