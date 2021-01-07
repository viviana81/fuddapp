//
//  Restaurant.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 28/11/20.
//

import Foundation

struct Restaurant: Codable, Hashable {
    
    let id: String
    let name: String
    let image: String
    let type: RestaurantType
    let price: Double
    let description: String
    let address: String
    let coordinates: Coordinate
}

struct RestaurantData {
    let main: [Restaurant]
    let nextToYou: [Restaurant]
    let lastViewed: [Restaurant]

}

enum RestaurantType: String, Codable {
    case sicilian
    case sushi
    case mexican
    case mediterran
    case pizza
     
    var fullTitle: String {
        switch self {
        case .sicilian:
            return "cucina siciliana"
        case .sushi:
            return "cucina giapponese"
        case .mediterran:
            return "cucina mediterranea"
        case .mexican:
            return "cucina messicana"
        case .pizza:
            return "pizza"
        }
    }
}

struct Coordinate: Codable, Hashable {
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}
