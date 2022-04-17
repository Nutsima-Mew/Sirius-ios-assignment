//
//  SearchLandingInteractor.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 16/4/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchLandingInteractorInterface {
  func getCities(request: SearchLanding.Cities.Request)
  
  var city: City? {get set}
}

class SearchLandingInteractor: SearchLandingInteractorInterface {
  var presenter: SearchLandingPresenterInterface!
  var worker: CityWorker!
  var city: City?

  // MARK: - Business logic
  
  func getCities(request: SearchLanding.Cities.Request) {
    worker.getCity { [weak self] result in
      let response = SearchLanding.Cities.Response(result: result, filter: request.filter)
      self?.presenter.presentCities(response: response)
    }
  }
}
