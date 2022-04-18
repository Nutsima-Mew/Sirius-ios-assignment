//
//  SearchLandingViewController.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 16/4/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchLandingViewControllerInterface: AnyObject {
  func displayCities(viewModel: SearchLanding.Cities.ViewModel)
}

class SearchLandingViewController: UIViewController, SearchLandingViewControllerInterface {
  var interactor: SearchLandingInteractorInterface!
  var router: SearchLandingRouterInterface!
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var noResultView: UIView!
  @IBOutlet private weak var searchBar: UISearchBar!
  
  var cities: [City] = []
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  // MARK: - Configuration
  
  private func configure(viewController: SearchLandingViewController) {
    let router = SearchLandingRouter()
    router.viewController = viewController
    
    let presenter = SearchLandingPresenter()
    presenter.viewController = viewController
    
    let interactor = SearchLandingInteractor()
    interactor.presenter = presenter
    
    let worker = CityWorker(store: CityStore())
    interactor.worker = worker
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTableViewCell()
    getCities()
  }
  
  // MARK: - Event handling
  
  private func setUpTableViewCell() {
    let bundle = Bundle(for: CityTableViewCell.self)
    let nibName = UINib(nibName: "CityTableViewCell", bundle: bundle)
    tableView.register(nibName, forCellReuseIdentifier: CityTableViewCell.identifier)
  }
  
  func getCities() {
    let request = SearchLanding.Cities.Request(filter: nil)
    interactor.getCities(request: request)
  }
  
  // MARK: - Display logic
  
  func displayCities(viewModel: SearchLanding.Cities.ViewModel) {
    
    DispatchQueue.main.async { [weak self] in
      switch viewModel.content {
      case .success(let result):
        self?.cities = result
        self?.noResultView.isHidden = true
        self?.tableView.isHidden = false
      case .failure(_):
        self?.noResultView.isHidden = false
        self?.tableView.isHidden = true
      }
      
      self?.tableView.reloadData()
    }
  }
}

extension SearchLandingViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    router.navigateToCityMap(city: cities[indexPath.row])
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cities.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

extension SearchLandingViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else {
      return UITableViewCell()
    }
    
    cell.updateUI(data: cities[indexPath.row])
    return cell
  }
}

extension SearchLandingViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText != "" {
      let request = SearchLanding.Cities.Request(filter: searchText)
      interactor.getSearchResult(request: request)
    } else {
      let request = SearchLanding.Cities.Request(filter: nil)
      interactor.getSearchResult(request: request)
    }
  }
}
