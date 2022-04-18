//
//  CityMapInteractorTests.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 18/4/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import CitySearch
import XCTest

class CityMapInteractorTests: XCTestCase {
  
  // MARK: - Subject under test
  
  var interactor: CityMapInteractor!
  var presenter: CityMapPresenterSpy!
  
  // MARK: - Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupCityMapInteractor()
  }
  
  // MARK: - Test setup
  
  func setupCityMapInteractor() {
    interactor = CityMapInteractor()
    
    presenter = CityMapPresenterSpy()
    interactor.presenter = presenter
  }
  
  // MARK: - Test doubles
  
  class CityMapPresenterSpy: CityMapPresenterInterface {
    
    var presentCityInfoCalled: Bool = false
    var presentCityInfoResponse: CityMap.CityInfo.Response?
    
    func presentCityInfo(response: CityMap.CityInfo.Response) {
      presentCityInfoCalled = true
      presentCityInfoResponse = response
    }
  }
  
  // MARK: - Tests
  
  func testGetCityInfoSuccessCase() {
    //Given
    let coordinates =  Coordinates(lon: -60.21767, lat: 46.236691)
    let city = City(country: "US", name: "Alabama", coord: coordinates)
    interactor.city = city
    
    let request = CityMap.CityInfo.Request()
    
    //When
    interactor.getCityInfo(request: request)
    
    //Then
    XCTAssertTrue(presenter.presentCityInfoCalled, "getCityInfo() should ask presenter to presentCityInfo()")
    if let response = presenter.presentCityInfoResponse?.info {
      XCTAssertEqual(response.country, city.country, "Country should equal to US")
      XCTAssertEqual(response.name, city.name, "City name should equal to Alabama")
    } else {
      XCTFail("Didn't get response from getCityInfo()")
    }
  }
  
  func testGetCityInfoWithCityNilValue() {
    //Given
    interactor.city = nil
    let request = CityMap.CityInfo.Request()
    
    //When
    interactor.getCityInfo(request: request)
    
    //Then
    XCTAssertFalse(presenter.presentCityInfoCalled, "getCityInfo() should ask presenter to presentCityInfo()")
    XCTAssertNil(presenter.presentCityInfoResponse?.info, "Country should equal to nil value")
  }
  
}
