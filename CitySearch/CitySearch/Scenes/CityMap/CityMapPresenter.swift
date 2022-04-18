//
//  CityMapPresenter.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 17/4/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CityMapPresenterInterface {
  func presentCityInfo(response: CityMap.CityInfo.Response)
}

class CityMapPresenter: CityMapPresenterInterface {
  weak var viewController: CityMapViewControllerInterface!

  // MARK: - Presentation logic
  
  func presentCityInfo(response: CityMap.CityInfo.Response) {
    let viewModel = CityMap.CityInfo.ViewModel(info: response.info)
    viewController.displayCityInfo(viewModel: viewModel)
  }
}
