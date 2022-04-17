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
      let sortedReult = result.sorted {$0.name.lowercased() < $1.name.lowercased()}
      let viewModel = SearchLanding.Cities.ViewModel(content: .success(result: sortedReult))
      viewController.displayCities(viewModel: viewModel)
    default:
      let viewModel = SearchLanding.Cities.ViewModel(content: .failure(error: .invalidJSON))
      viewController.displayCities(viewModel: viewModel)
    }
  }
  
  private func sortCityName() {}
}
