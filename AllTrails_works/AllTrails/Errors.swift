//
//  Errors.swift
//  AllTrails
//
//  Created by Rick W. on 11/25/23.
//

import Foundation

enum NetworkError: Error {
  case requestFailed
}
enum LocationError: Error {
  case locationUnavailable
}
