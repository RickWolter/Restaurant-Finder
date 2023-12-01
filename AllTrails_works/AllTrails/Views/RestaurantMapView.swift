//
//  RestaurantMapView.swift
//  AllTrails
//
//  Created by Rick W. on 11/21/23.
//

import SwiftUI
import MapKit

struct RestaurantMapView: View {
  var viewModel: RestaurantListViewModel
  @State private var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), // Default to a central location or user's location
    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
  )
  
  var body: some View {
    Map(coordinateRegion: $region, annotationItems: viewModel.restaurants) { restaurant in
      MapMarker(coordinate: CLLocationCoordinate2D(latitude: restaurant.geometry.location.lat, longitude: restaurant.geometry.location.lng), tint: .red)
    }
    .task {
      await viewModel.fetchRestaurants()
      if let firstRestaurant = viewModel.restaurants.first {
        region.center = CLLocationCoordinate2D(latitude: firstRestaurant.geometry.location.lat, longitude: firstRestaurant.geometry.location.lng)
      }
    }
  }
}
