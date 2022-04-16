//
//  SearchLandingViewController.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 16/4/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchLandingViewControllerInterface: AnyObject {
  
}

class SearchLandingViewController: UIViewController, SearchLandingViewControllerInterface {
  var interactor: SearchLandingInteractorInterface!
  var router: SearchLandingRouterInterface!
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var noResultView: UIView!
  @IBOutlet private weak var searchField: UITextField!
  
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

extension SearchLandingViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

extension SearchLandingViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}
