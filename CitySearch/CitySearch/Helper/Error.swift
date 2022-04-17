//
//  Error.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 17/4/2565 BE.
//

import Foundation
public enum ResultError: Error {
  case invalidJSON
  case invalidData
}

public enum Result<T> {
  case success(result: T)
  case failure(error: ResultError)
}

public enum Content<T> {
  case success(result: T)
  case failure(error: ResultError)
}
