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
    let viewModel = SearchLanding.Cities.ViewModel(content: response.result)
    viewController.displayCities(viewModel: viewModel)
  }
}
