//
//  RestaurantListViewModel.swift
//  AllTrails
//
//  Created by Rick W. on 11/20/23.
//

import Foundation
import CoreLocation
import SwiftUI
import Observation

@Observable
final class RestaurantListViewModel {
  
  var locationManager = LocationManager()
  var networkManager = NetworkManager()
  
  var restaurants: [Place] = []
  var searchText = ""
  
  var isLoading = false
  var errorMessage: String?
  
  var filteredRestaurants: [Place] {
    if searchText.isEmpty {
      return restaurants
    } else {
      return restaurants.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
    }
  }

  
  func requestLocation()  {
    locationManager.requestLocation()
  }
  
  
  func fetchRestaurants() async {
    
    isLoading = true
    errorMessage = nil
    
    let coordinates =  await locationManager.getLatestCoordinates()
   
    do {
      restaurants = try await networkManager.fetchNearbyRestaurants(coordinates: coordinates)
    } catch {
      errorMessage = error.localizedDescription
    }
    isLoading = false
  }
}
