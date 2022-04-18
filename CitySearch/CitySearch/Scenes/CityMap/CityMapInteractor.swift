//
//  CityMapInteractor.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 17/4/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CityMapInteractorInterface {
  func getCityInfo(request: CityMap.CityInfo.Request)
  
  var city: City? {get set}
}

class CityMapInteractor: CityMapInteractorInterface {
  var presenter: CityMapPresenterInterface!
  var city: City?

  // MARK: - Business logic
  
  func getCityInfo(request: CityMap.CityInfo.Request) {
    guard let city = city else {
      return
    }
    
    let response = CityMap.CityInfo.Response(info: city)
    presenter.presentCityInfo(response: response)
  }
}
