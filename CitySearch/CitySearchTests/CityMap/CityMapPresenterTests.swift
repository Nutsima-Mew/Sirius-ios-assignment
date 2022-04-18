//
//  CityMapPresenterTests.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 18/4/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import CitySearch
import XCTest

class CityMapPresenterTests: XCTestCase {

  // MARK: - Subject under test

  var presenter: CityMapPresenter!
  var viewController: CityMapViewControllerSpy!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupCityMapPresenter()
  }

  // MARK: - Test setup

  func setupCityMapPresenter() {
    presenter = CityMapPresenter()
    viewController = CityMapViewControllerSpy()
    presenter.viewController = viewController
  }

  // MARK: - Test doubles
  
  class CityMapViewControllerSpy: CityMapViewControllerInterface {
    var displayCityInfoCalled: Bool = false
    var displayCityInfoViewModel: CityMap.CityInfo.ViewModel?
    
    func displayCityInfo(viewModel: CityMap.CityInfo.ViewModel) {
      displayCityInfoCalled = true
      displayCityInfoViewModel = viewModel
    }
  }

  // MARK: - Tests

  func testPresentCityInfo() {
    //Given
    let coordinates =  Coordinates(lon: -60.21767, lat: 46.236691)
    let city = City(country: "US", name: "Alabama", coord: coordinates)
    let response = CityMap.CityInfo.Response(info: city)
    
    //When
    presenter.presentCityInfo(response: response)
    
    //Then
    XCTAssertTrue(viewController.displayCityInfoCalled, "getCityInfo() should ask presenter to presentCityInfo()")
    if let viewModel = viewController.displayCityInfoViewModel?.info {
      XCTAssertEqual(viewModel.country, city.country, "Country should equal to US")
      XCTAssertEqual(viewModel.name, city.name, "City name should equal to Alabama")
    } else {
      XCTFail("Didn't get response from presentCityInfo()")
    }
  }
}
