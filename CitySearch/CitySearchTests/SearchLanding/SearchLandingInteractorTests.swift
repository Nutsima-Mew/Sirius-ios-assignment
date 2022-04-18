//
//  SearchLandingInteractorTests.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 18/4/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import CitySearch
import XCTest

class SearchLandingInteractorTests: XCTestCase {
  
  // MARK: - Subject under test
  
  var interactor: SearchLandingInteractor!
  var presenter: SearchLandingPresenterSpy!
  var worker: CityWorkerSpy!
  
  // MARK: - Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupSearchLandingInteractor()
  }
  
  // MARK: - Test setup
  
  func setupSearchLandingInteractor() {
    interactor = SearchLandingInteractor()
    presenter = SearchLandingPresenterSpy()
    interactor.presenter = presenter
    worker = CityWorkerSpy(store: CityMockStore())
    interactor.worker = worker
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
  
  class SearchLandingPresenterSpy: SearchLandingPresenterInterface {
    
    var presentCitiesCalled: Bool = false
    var presentCitiesResponse: SearchLanding.Cities.Response?
    
    func presentCities(response: SearchLanding.Cities.Response) {
      presentCitiesCalled = true
      presentCitiesResponse = response
    }
  }
  
  class CityWorkerSpy: CityWorker {
    
    var forceFailure: Bool = false
    var getCityCalled: Bool = false
    
    override func getCity(_ completion: @escaping (Result<[City]>) -> Void) {
      getCityCalled = true
      
      if forceFailure {
        completion(.failure(error: .invalidJSON))
      } else {
        super.getCity(completion)
      }
    }
  }
  
  // MARK: - Tests
  func testGetCitiesSuccessCase() {
    //Given
    let cities = getCity()
    let request = SearchLanding.Cities.Request(filter: nil)
    
    //When
    interactor.getCities(request: request)
    
    //Then
    XCTAssertTrue(worker.getCityCalled, "getCities() should call worker to getCity() JSON response data")
    XCTAssertTrue(presenter.presentCitiesCalled, "getCities() should ask presenter to presentCities()")
    if let response = presenter.presentCitiesResponse?.result {
      switch response {
      case .success(let result):
        XCTAssertEqual(result.count, cities.count, "The number of result should equal to 5")
        XCTAssertEqual(result.first?.country, cities.first?.country, "First country should equal to US")
        XCTAssertEqual(result.first?.name, cities.first?.name, "First city name should equal to Alabama")
      default:
        XCTFail("presentCities() didn't get success response")
      }
    } else {
      XCTFail("Didn't get response from presentCities()")
    }
  }
  
  func testGetCitiesFailureCase() {
    //Given
    worker.forceFailure = true
    let request = SearchLanding.Cities.Request(filter: nil)
    
    //When
    interactor.getCities(request: request)
    
    //Then
    XCTAssertTrue(worker.getCityCalled, "getCities() should call worker to getCity() JSON response data")
    XCTAssertTrue(presenter.presentCitiesCalled, "getCities() should ask presenter to presentCities()")
    if let response = presenter.presentCitiesResponse?.result {
      switch response {
      case .failure(let error):
        XCTAssertEqual(error, ResultError.invalidJSON, "error should equal to invalidJSON")
      default:
        XCTFail("presentCities() didn't get failure response")
      }
    } else {
      XCTFail("Didn't get response from getCities()")
    }
  }
  
  func testGetSearchResultWithEmptyInput() {
    //Given
    let cities = getCity()
    interactor.citiesData = cities
    let request = SearchLanding.Cities.Request(filter: "")
    
    //When
    interactor.getSearchResult(request: request)
    
    //Then
    XCTAssertFalse(worker.getCityCalled, "getCities() should not call worker to getCity() JSON response data")
    XCTAssertTrue(presenter.presentCitiesCalled, "getCities() should ask presenter to presentCities()")
    if let response = presenter.presentCitiesResponse?.result {
      switch response {
      case .success(let result):
        XCTAssertEqual(result.count, cities.count, "The number of result should equal to 5")
        XCTAssertEqual(result.first?.country, cities.first?.country, "First country should equal to US")
        XCTAssertEqual(result.first?.name, cities.first?.name, "First city name should equal to Alabama")
      default:
        XCTFail("presentCities() didn't get success response")
      }
    } else {
      XCTFail("Didn't get response from presentCities()")
    }
  }
  
  func testGetSearchResultWithValidInput() {
    //Given
    let cities = getCity()
    interactor.citiesData = cities
    let request = SearchLanding.Cities.Request(filter: "Zavety")
    
    //When
    interactor.getSearchResult(request: request)
    
    //Then
    XCTAssertFalse(worker.getCityCalled, "getCities() should not call worker to getCity() JSON response data")
    XCTAssertTrue(presenter.presentCitiesCalled, "getCities() should ask presenter to presentCities()")
    if let response = presenter.presentCitiesResponse?.result {
      switch response {
      case .success(let result):
        XCTAssertEqual(result.count, cities.count, "The number of result should equal to 5")
        XCTAssertEqual(result.first?.country, cities.first?.country, "First country should equal to US")
        XCTAssertEqual(result.first?.name, cities.first?.name, "First city name should equal to Alabama")
      default:
        XCTFail("presentCities() didn't get success response")
      }
    } else {
      XCTFail("Didn't get response from presentCities()")
    }
  }
  
  func testGetSearchResultWithInvalidInput() {
    //Given
    let cities = getCity()
    interactor.citiesData = cities
    let request = SearchLanding.Cities.Request(filter: "+")
    
    //When
    interactor.getSearchResult(request: request)
    
    //Then
    XCTAssertFalse(worker.getCityCalled, "getCities() should not call worker to getCity() JSON response data")
    XCTAssertTrue(presenter.presentCitiesCalled, "getCities() should ask presenter to presentCities()")
    if let response = presenter.presentCitiesResponse?.result {
      switch response {
      case .success(let result):
        XCTAssertEqual(result.count, cities.count, "The number of result should equal to 5")
        XCTAssertEqual(result.first?.country, cities.first?.country, "First country should equal to US")
        XCTAssertEqual(result.first?.name, cities.first?.name, "First city name should equal to Alabama")
      default:
        XCTFail("presentCities() didn't get success response")
      }
    } else {
      XCTFail("Didn't get response from presentCities()")
    }
  }
}
