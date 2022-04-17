//
//  CityModels.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 17/4/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

public struct City: Codable {
  let country: String
  let name: String
  let coord: Coordinates
  
  public init(country: String,
              name: String,
              coord: Coordinates) {
    self.country = country
    self.name = name
    self.coord = coord
  }
}

// MARK: - Coord
public struct Coordinates: Codable {
  let lon: Double
  let lat: Double
  
  public init(lon: Double,
              lat: Double) {
    self.lon = lon
    self.lat = lat
  }
}
