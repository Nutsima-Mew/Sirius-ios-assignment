//
//  CityMockStore.swift
//  CitySearchTests
//
//  Created by NUTSIMA NONGYAI on 18/4/2565 BE.
//

import Foundation
@testable import CitySearch

class CityMockStore: CityStoreProtocol {
  
  func getCity(_ completion: @escaping (Result<[City]>) -> Void) {
    let coordinatesUA =  Coordinates(lon: -86.750259, lat: 32.750408)
    let coordinatesUS =  Coordinates(lon: -106.651138, lat: 35.084492)
    let coordinatesDE =  Coordinates(lon: 13.40637, lat: 52.398441)
    let coordinatesRU =  Coordinates(lon: 37.849998, lat: 56.049999)
    let coordinatesCA =  Coordinates(lon: -60.21767, lat: 46.236691)
    let cities: [City] = [City(country: "US", name: "Alabama", coord: coordinatesUA),
                          City(country: "US", name: "Albuquerque", coord: coordinatesUS),
                          City(country: "DE", name: "Zavety Il’icha", coord: coordinatesDE),
                          City(country: "RU", name: "Cherkizovo", coord: coordinatesRU),
                          City(country: "CA", name: "Sydney Mines", coord: coordinatesCA)]
    completion(.success(result: cities))
  }
}
