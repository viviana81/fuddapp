//
//  Restaurant.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 28/11/20.
//

import Foundation

struct Restaurant: Decodable, Hashable {
    let id: String
    let name: String
    let image: String
}

struct RestaurantData {
    let main: [Restaurant]
    let nextToYou: [Restaurant]
    let lastViewed: [Restaurant]

}
