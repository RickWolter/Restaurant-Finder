//
//  NetworkManager.swift
//  AllTrails
//
//  Created by Rick W. on 11/20/23.
//

import Foundation

import CoreLocation


class NetworkManager {
  
  let radius = 500 // Example radius in meters
  //let apiKey = "AIzaSyDJawejhdG91pmdv935WyfoF8e_YuDMiSw" // my API key
  let apiKey = "AIzaSyDJwPArVzS_dlyharx1KIrA3wbd9PnPQY8" // API key provided
  private var places: [Place] = []
  
  
  func fetchNearbyRestaurants(coordinates: CLLocationCoordinate2D) async throws -> [Place] {
    
    var urlComponents = URLComponents(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json")
    urlComponents?.queryItems = [
      .init(name: "location", value: "\(coordinates.latitude),\(coordinates.longitude)"),
      .init(name: "radius", value: "1000"),
      .init(name: "type", value: "restaurant"),
      .init(name: "key", value: apiKey),
    ]
    
    guard let url = urlComponents?.url else {
      throw URLError(.badURL)
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    let decodedResponse = try JSONDecoder().decode(PlacesResponse.self, from: data)
    
    return decodedResponse.results
  }
}
