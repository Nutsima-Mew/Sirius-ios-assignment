//
//  Unwrapper.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 17/4/2565 BE.
//

import Foundation

func unwrapped<T: OptionalType, U>(_ wrapped: T, with castValue: U) -> T.WrappedType where T.WrappedType == U {
  if let unwrapped = wrapped.value {
    return unwrapped
  } else {
    return castValue
  }
}

protocol OptionalType: ExpressibleByNilLiteral {
  associatedtype WrappedType
  var value: WrappedType? { get }
}

extension Optional: OptionalType {
  public var value: Wrapped? { return self }
}
