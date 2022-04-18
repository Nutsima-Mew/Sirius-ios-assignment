//
//  CityMapViewController.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 17/4/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol CityMapViewControllerInterface: AnyObject {
  func displayCityInfo(viewModel: CityMap.CityInfo.ViewModel)
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
    getCityInfo()
  }
  
  // MARK: - Event handling
  
  func getCityInfo() {
    let request = CityMap.CityInfo.Request()
    interactor.getCityInfo(request: request)
  }
  
  // MARK: - Display logic
  
  func displayCityInfo(viewModel: CityMap.CityInfo.ViewModel) {
    let cityName = viewModel.info.name
    let countryName = viewModel.info.country
    let Longitude = viewModel.info.coord.lon
    let Latitude = viewModel.info.coord.lat
    
    city.text = "\(cityName), \(countryName)"
    lon.text = "Longitude: \(Longitude)"
    lat.text = "Latitude: \(Latitude)"
    displayLocation(coordinates: viewModel.info.coord)
  }
  
  private func displayLocation(coordinates: Coordinates) {
    let Longitude = coordinates.lon
    let Latitude = coordinates.lat
    let mapLocation = MKPointAnnotation()
    mapLocation.coordinate = CLLocationCoordinate2D(latitude: Latitude, longitude: Longitude)
    let initialLocation = CLLocation(latitude: Latitude, longitude: Longitude)
    map.addAnnotation(mapLocation)
    map.centerToLocation(initialLocation)
  }
}

private extension MKMapView {
  func centerToLocation ( _ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
