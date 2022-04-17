//
//  SearchLandingModels.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 16/4/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct SearchLanding {
  
  struct Cities {
    struct Request {
      let filter: String?
    }
    struct Response {
      var result: Result<[City]>
      let filter: String?
    }
    struct ViewModel {
      var content: Result<[City]>
    }
  }
}
