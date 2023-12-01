//
//  PlacesResponse.swift
//  AllTrails
//
//  Created by Rick W. on 11/20/23.
//

import Foundation

struct PlacesResponse: Decodable {
  let results: [Place]
}

struct Place: Decodable, Identifiable {
  let id: UUID
  
  let name: String
  let vicinity: String
  let rating: Double?
  let geometry: Geometry
  let openingHours: OpeningHours?
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = UUID()
    self.name = try container.decode(String.self, forKey: .name)
    self.vicinity = try container.decode(String.self, forKey: .vicinity)
    self.rating = try container.decodeIfPresent(Double.self, forKey: .rating)
    self.geometry = try container.decode(Geometry.self, forKey: .geometry)
    self.openingHours = try container.decodeIfPresent(OpeningHours.self, forKey: .openingHours)
  }
  
  enum CodingKeys: String, CodingKey {
    case name
    case vicinity
    case rating
    case geometry
    case openingHours = "opening_hours"
  }
}


struct Geometry: Decodable {
  let location: Location
}

struct Location: Decodable {
  let lat: Double
  let lng: Double
}

struct OpeningHours: Decodable {
  let openNow: Bool
  
  enum CodingKeys: String, CodingKey {
    case openNow = "open_now"
    
  }
}
