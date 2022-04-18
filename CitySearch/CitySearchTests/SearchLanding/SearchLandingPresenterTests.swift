//
//  SearchLandingPresenterTests.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 18/4/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import CitySearch
import XCTest

class SearchLandingPresenterTests: XCTestCase {
  
  // MARK: - Subject under test
  
  var presenter: SearchLandingPresenter!
  var viewController: SearchLandingViewControllerSpy!
  
  // MARK: - Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupSearchLandingPresenter()
  }
  
  // MARK: - Test setup
  
  func setupSearchLandingPresenter() {
    presenter = SearchLandingPresenter()
    viewController = SearchLandingViewControllerSpy()
    presenter.viewController = viewController
  }
  
  func getCity() -> [City] {
    let coordinatesUA =  Coordinates(lon: -86.750259, lat: 32.750408)
    let coordinatesUS =  Coordinates(lon: -106.651138, lat: 35.084492)
    let coordinatesDE =  Coordinates(lon: 13.40637, lat: 52.398441)
    let coordinatesRU =  Coordinates(lon: 37.849998, lat: 56.049999)
    let coordinatesCA =  Coordinates(lon: -60.21767, lat: 46.236691)
    let cities: [City] = [City(country: "US", name: "Alabama", coord: coordinatesUA),
                          City(country: "US", name: "Albuquerque", coord: coordinatesUS),
                          City(country: "DE", name: "Zavety Il’icha", coord: coordinatesDE),
                          City(country: "RU", name: "Cherkizovo", coord: coordinatesRU),
                          City(country: "CA", name: "Sydney Mines", coord: coordinatesCA)]
    let result = cities.sorted {$0.name.lowercased() < $1.name.lowercased()}
    return result
  }
  
  // MARK: - Test doubles
  
  class SearchLandingViewControllerSpy: SearchLandingViewControllerInterface {
    
    var displayCitiesCalled: Bool = false
    var displayCitiesViewModel: SearchLanding.Cities.ViewModel?
    
    func displayCities(viewModel: SearchLanding.Cities.ViewModel) {
      displayCitiesCalled = true
      displayCitiesViewModel = viewModel
    }
  }
  
  // MARK: - Tests
  
  func testGetSearchResultWithNilInput() {
    //Given
    let cities = getCity()
    let response = SearchLanding.Cities.Response(result: .success(result: cities), filter: nil)
    
    //When
    presenter.presentCities(response: response)
    
    //Then
    XCTAssertTrue(viewController.displayCitiesCalled, "presentCities() should ask presenter to displayCities()")
    if let viewModel = viewController.displayCitiesViewModel?.content {
      switch viewModel {
      case .success(let result):
        XCTAssertEqual(result.count, cities.count, "The number of result should equal to 5")
        XCTAssertEqual(result.first?.country, cities.first?.country, "First country result should equal to US")
        XCTAssertEqual(result.first?.name, cities.first?.name, "First city result name should equal to Alabama")
      default:
        XCTFail("displayCities() didn't get success response")
      }
    } else {
      XCTFail("Didn't get response from presentCities()")
    }
  }
  
  func testGetSearchResultWithEmptyInput() {
    //Given
    let cities = getCity()
    let response = SearchLanding.Cities.Response(result: .success(result: cities), filter: "")
    
    //When
    presenter.presentCities(response: response)
    
    //Then
    XCTAssertTrue(viewController.displayCitiesCalled, "presentCities() should ask presenter to displayCities()")
    if let viewModel = viewController.displayCitiesViewModel?.content {
      switch viewModel {
      case .success(let result):
        XCTAssertEqual(result.count, cities.count, "The number of result should equal to 5")
        XCTAssertEqual(result.first?.country, cities.first?.country, "First country result should equal to US")
        XCTAssertEqual(result.first?.name, cities.first?.name, "First city result name should equal to Alabama")
      default:
        XCTFail("displayCities() didn't get success response")
      }
    } else {
      XCTFail("Didn't get response from presentCities()")
    }
  }
  
  func testGetSearchResultWithSPrefixInput() {
    //Given
    let cities = getCity()
    let response = SearchLanding.Cities.Response(result: .success(result: cities), filter: "s")
    
    //When
    presenter.presentCities(response: response)
    
    //Then
    XCTAssertTrue(viewController.displayCitiesCalled, "presentCities() should ask presenter to displayCities()")
    if let viewModel = viewController.displayCitiesViewModel?.content {
      switch viewModel {
      case .success(let result):
        XCTAssertEqual(result.count, 1, "The number of result should equal to 1")
        XCTAssertEqual(result.first?.country, cities[3].country, "Country result should equal to CA")
        XCTAssertEqual(result.first?.name, cities[3].name, "City result name should equal to Sydney Mines")
      default:
        XCTFail("displayCities() didn't get success response")
      }
    } else {
      XCTFail("Didn't get response from presentCities()")
    }
  }
  
  func testGetSearchResultWithAlPrefixInput() {
    //Given
    let cities = getCity()
    let response = SearchLanding.Cities.Response(result: .success(result: cities), filter: "Al")
    
    //When
    presenter.presentCities(response: response)
    
    //Then
    XCTAssertTrue(viewController.displayCitiesCalled, "presentCities() should ask presenter to displayCities()")
    if let viewModel = viewController.displayCitiesViewModel?.content {
      switch viewModel {
      case .success(let result):
        XCTAssertEqual(result.count, 2, "The number of result should equal to 2")
        XCTAssertEqual(result.first?.country, cities.first?.country, "First country result should equal to US")
        XCTAssertEqual(result.first?.name, cities.first?.name, "First city result name should equal to Alabama")
        XCTAssertEqual(result.last?.country, cities[1].country, "Second country result should equal to US")
        XCTAssertEqual(result.last?.name, cities[1].name, "Second city result name should equal to Albuquerque")
      default:
        XCTFail("displayCities() didn't get success response")
      }
    } else {
      XCTFail("Didn't get response from presentCities()")
    }
  }
  
  func testGetSearchResultWithAlbPrefixInput() {
    //Given
    let cities = getCity()
    let response = SearchLanding.Cities.Response(result: .success(result: cities), filter: "Alb")
    
    //When
    presenter.presentCities(response: response)
    
    //Then
    XCTAssertTrue(viewController.displayCitiesCalled, "presentCities() should ask presenter to displayCities()")
    if let viewModel = viewController.displayCitiesViewModel?.content {
      switch viewModel {
      case .success(let result):
        XCTAssertEqual(result.count, 1, "The number of result should equal to 1")
        XCTAssertEqual(result.first?.country, cities[1].country, "Country result should equal to US")
        XCTAssertEqual(result.first?.name, cities[1].name, "City result name should equal to Albuquerque")
      default:
        XCTFail("displayCities() didn't get success response")
      }
    } else {
      XCTFail("Didn't get response from presentCities()")
    }
  }
  
  func testGetSearchResultWithValidInput() {
    //Given
    let cities = getCity()
    let response = SearchLanding.Cities.Response(result: .success(result: cities), filter: "Zavety")
    
    //When
    presenter.presentCities(response: response)
    
    //Then
    XCTAssertTrue(viewController.displayCitiesCalled, "presentCities() should ask presenter to displayCities()")
    if let viewModel = viewController.displayCitiesViewModel?.content {
      switch viewModel {
      case .success(let result):
        XCTAssertEqual(result.count, 1, "The number of result should equal to 1")
        XCTAssertEqual(result.first?.country, cities.last?.country, "Country result should equal to DE")
        XCTAssertEqual(result.first?.name, cities.last?.name, "City result name should equal to Zavety Il’icha")
      default:
        XCTFail("displayCities() didn't get success response")
      }
    } else {
      XCTFail("Didn't get response from presentCities()")
    }
  }
  
  func testGetSearchResultWithInvalidInput() {
    //Given
    let cities = getCity()
    let response = SearchLanding.Cities.Response(result: .success(result: cities), filter: "CountryTest")
    
    //When
    presenter.presentCities(response: response)
    
    //Then
    XCTAssertTrue(viewController.displayCitiesCalled, "presentCities() should ask presenter to displayCities()")
    if let viewModel = viewController.displayCitiesViewModel?.content {
      switch viewModel {
      case .success(let result):
        XCTAssertEqual(result.count, 0, "The number of result should equal to 0")
        XCTAssertNil(result.first?.country, "Country result should equal nil value")
        XCTAssertNil(result.first?.name, "Cityresult name should equal to nil value")
      default:
        XCTFail("displayCities() didn't get success response")
      }
    } else {
      XCTFail("Didn't get response from presentCities()")
    }
  }
  
  func testGetSearchResultWithInvalidSymbolInput() {
    //Given
    let cities = getCity()
    let response = SearchLanding.Cities.Response(result: .success(result: cities), filter: "+")
    
    //When
    presenter.presentCities(response: response)
    
    //Then
    XCTAssertTrue(viewController.displayCitiesCalled, "presentCities() should ask presenter to displayCities()")
    if let viewModel = viewController.displayCitiesViewModel?.content {
      switch viewModel {
      case .success(let result):
        XCTAssertEqual(result.count, 0, "The number of result should equal to 0")
        XCTAssertNil(result.first?.country, "Country result should equal nil value")
        XCTAssertNil(result.first?.name, "Cityresult name should equal to nil value")
      default:
        XCTFail("displayCities() didn't get success response")
      }
    } else {
      XCTFail("Didn't get response from presentCities()")
    }
  }
  
  func testGetSearchResultWithFailureCase() {
    //Given
    let response = SearchLanding.Cities.Response(result: .failure(error: ResultError.invalidJSON), filter: "+")
    
    //When
    presenter.presentCities(response: response)
    
    //Then
    XCTAssertTrue(viewController.displayCitiesCalled, "presentCities() should ask presenter to displayCities()")
    if let viewModel = viewController.displayCitiesViewModel?.content {
      switch viewModel {
      case .failure(let error):
        XCTAssertEqual(error, ResultError.invalidJSON, "error should equal to invalidJSON")
      default:
        XCTFail("displayCities() didn't get failure response")
      }
    } else {
      XCTFail("Didn't get response from presentCities()")
    }
  }
}
