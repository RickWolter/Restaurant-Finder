//
//  TabView.swift
//  AllTrails
//
//  Created by Rick W. on 11/21/23.
//

import SwiftUI

enum Tab {
  case list
  case map
}

struct TabContentView: View {
  @State private var viewModel = RestaurantListViewModel()
  @State private var selection: Tab = .list
  
  var body: some View {
    TabView(){
      RestaurantListView(viewModel: viewModel)
        .tabItem {
          Label("List", systemImage: "list.bullet")
        }
        .tag(Tab.list)
      
      RestaurantMapView(viewModel: viewModel)
        .tabItem {
          Label("Map", systemImage: "map")
        }
        .tag(Tab.map)
    }
  }
}


