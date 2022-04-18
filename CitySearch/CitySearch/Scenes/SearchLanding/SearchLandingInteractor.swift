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
  func getSearchResult(request: SearchLanding.Cities.Request)
}

class SearchLandingInteractor: SearchLandingInteractorInterface {
  var presenter: SearchLandingPresenterInterface!
  var worker: CityWorker!
  var citiesData: [City] = []
  
  // MARK: - Business logic
  
  func getSearchResult(request: SearchLanding.Cities.Request) {
    let response = SearchLanding.Cities.Response(result: .success(result: citiesData), filter: request.filter)
    presenter.presentCities(response: response)
  }
  
  func getCities(request: SearchLanding.Cities.Request) {
    worker.getCity { [weak self] result in
      switch result {
      case .success(let data):
        let city = data.sorted {$0.name.lowercased() < $1.name.lowercased()}
        self?.citiesData = city
        let response = SearchLanding.Cities.Response(result: .success(result: city), filter: request.filter)
        self?.presenter.presentCities(response: response)
      case .failure(let error):
        let response = SearchLanding.Cities.Response(result: .failure(error: error), filter: request.filter)
        self?.presenter.presentCities(response: response)
      }
    }
  }
}
