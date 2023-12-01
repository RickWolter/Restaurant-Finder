//
//  ContentView.swift
//  AllTrails
//
//  Created by Rick W. on 11/19/23.
//

import SwiftUI
import CoreLocation
import Observation


struct RestaurantListView: View {
  
  @State var viewModel: RestaurantListViewModel
  @State private var isLoading = false
  
  var body: some View {
    
    VStack {
      
      TextField("Search", text:  $viewModel.searchText)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
      Spacer()
      
      switch viewModel.locationManager.authorizationStatus {
        
      case .authorizedWhenInUse,.authorizedAlways:
        
        List(viewModel.filteredRestaurants, id: \.name) { restaurant in
          VStack(alignment: .leading) {
            
            Text(restaurant.name).accessibilityLabel("The restaurant's name is  \(restaurant.name).")
            
            HStack {
              if let rating = restaurant.rating {
                
                Stars(numberOfRating: rating)
                Text("Rating: \(rating.formatted(.number))")
                  .accessibilityLabel("The restaurant has \(rating.formatted(.number)) stars.")
              } else {
                Text("Rating: 0 ratings")
                  .accessibilityLabel("The restaurant has \(0) stars.")
              }
            }
            Text(restaurant.vicinity)
            
            switch restaurant.openingHours?.openNow {
            case true:
              Text("Open").padding(8.0).foregroundColor(.white)
                .background(.green).clipShape(RoundedRectangle(
                  cornerRadius: 20,
                  style: .continuous
                )).font(.caption.bold())
                .accessibilityLabel("The restaurant \(restaurant.name) is open.")
            case false:
              Text("Closed")
                .padding(8.0)
                .foregroundColor(.white)
                .background(.red)
                .clipShape(RoundedRectangle(
                  cornerRadius: 20,
                  style: .continuous
                )).font(.caption.bold())
                .accessibilityLabel("The restaurant \(restaurant.name) is closed.")
            default: Text("No info for hours")
                .padding(8.0)
                .foregroundColor(.white)
                .background(.blue)
                .clipShape(RoundedRectangle(
                  cornerRadius: 20,
                  style: .continuous
                )).font(.caption.bold())
                .accessibilityLabel("The restaurant \(restaurant.name) has no store hours available.")
            }
          }
        }.task {
          await viewModel.fetchRestaurants()
        }
        .overlay {
          if viewModel.isLoading{
            ProgressView()
          }
        }
      case .restricted, .denied:
        Text("Current location data was restricted or denied.")
      case .notDetermined:
        Text("Finding your location...")
        ProgressView()
        
      default:
        ProgressView()
      }
    }.background(Color(red: 64/255, green: 104/255, blue: 60/255))
  }
}



struct Stars: View {
  var numberOfRating: Double
  
  var body: some View {
    
    ForEach(1...Int(numberOfRating),  id: \.self) {_ in
      Text(Image(systemName: "star.fill")).foregroundStyle(.yellow)
    }
    if numberOfRating.truncatingRemainder(dividingBy: 1.0) > 0.49 {
      Text(Image(systemName: "star.leadinghalf.filled")).foregroundStyle(.yellow)
    }
  }
}

