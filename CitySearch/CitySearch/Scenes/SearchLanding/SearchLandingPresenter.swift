//
//  SearchLandingPresenter.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 16/4/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchLandingPresenterInterface {
  func presentCities(response: SearchLanding.Cities.Response)
}

class SearchLandingPresenter: SearchLandingPresenterInterface {
  weak var viewController: SearchLandingViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentCities(response: SearchLanding.Cities.Response) {
    switch response.result {
    case .success(let result):
      var cities: [City] = []
      
      if let filter = response.filter {
        let filtered = result.filter({ city in
          city.name.lowercased().hasPrefix(filter.lowercased())
        })
        cities = filtered
      } else {
        cities = result
      }

      let viewModel = SearchLanding.Cities.ViewModel(content: .success(result: cities))
      viewController.displayCities(viewModel: viewModel)
    default:
      let viewModel = SearchLanding.Cities.ViewModel(content: .failure(error: .invalidJSON))
      viewController.displayCities(viewModel: viewModel)
    }
  }
}
