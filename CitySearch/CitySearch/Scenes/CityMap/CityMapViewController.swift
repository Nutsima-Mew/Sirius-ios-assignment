//
//  CityMapViewController.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 17/4/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import MapKit

protocol CityMapViewControllerInterface: AnyObject {
  
}

class CityMapViewController: UIViewController, CityMapViewControllerInterface {
  var interactor: CityMapInteractorInterface!
  var router: CityMapRouterInterface!

  @IBOutlet private weak var map: MKMapView!
  @IBOutlet private weak var city: UILabel!
  @IBOutlet private weak var lon: UILabel!
  @IBOutlet private weak var lat: UILabel!
  
  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

  // MARK: - Configuration

  private func configure(viewController: CityMapViewController) {
    let router = CityMapRouter()
    router.viewController = viewController

    let presenter = CityMapPresenter()
    presenter.viewController = viewController

    let interactor = CityMapInteractor()
    interactor.presenter = presenter

    viewController.interactor = interactor
    viewController.router = router
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: - Event handling

  // MARK: - Display logic

  // MARK: - Router

}
