//
//  RestaurantProvider.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 29/11/20.
//

import Foundation

struct RestaurantProvider {
    static var data: RestaurantData {
        return RestaurantData(main: Restaurant.main, nextToYou: Restaurant.nextToYou, lastViewed: Restaurant.lastViewed)
    }
}
