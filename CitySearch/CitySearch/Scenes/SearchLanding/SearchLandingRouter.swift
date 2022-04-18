//
//  SearchLandingRouter.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 16/4/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchLandingRouterInterface {
  func navigateToCityMap(city: City)
}

class SearchLandingRouter: SearchLandingRouterInterface {
  weak var viewController: SearchLandingViewController!
  
  // MARK: - Navigation
  func navigateToCityMap(city: City) {
    let storyBoard: UIStoryboard = UIStoryboard(name: "CityMap", bundle: nil)
    let destinationVC = storyBoard.instantiateViewController(withIdentifier: "CityMap") as! CityMapViewController
    destinationVC.interactor.city = city
    viewController.navigationController?.pushViewController(destinationVC, animated: true)
  }
}
