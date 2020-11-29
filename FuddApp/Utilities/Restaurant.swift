//
//  Restaurant.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 28/11/20.
//

import Foundation

struct Restaurant: Hashable {
    let id: String
    let name: String
    let image: String
    
    static var main: [Restaurant] {
        return [
            Restaurant(id: "1", name: "Mezzogrammo", image: "https://media-cdn.tripadvisor.com/media/photo-s/1b/9a/41/f6/la-margherita-cotta-nel.jpg"),
            Restaurant(id: "2", name: "Liolà", image: "https://media-cdn.tripadvisor.com/media/photo-s/17/0f/0d/f9/gran-frutti-di-mare-su.jpg"),
            Restaurant(id: "3", name: "Pizza Telefono", image: "https://just-eat-prod-eu-res.cloudinary.com/image/upload/c_fill,d_it:cuisines:pizza-0.jpg,f_auto,q_auto,w_500/v1/it/restaurants/208090.jpg")
        ]
    }
    
    static var lastViewed: [Restaurant] {
        return [
            Restaurant(id: "4", name: "Mezzogrammo", image: "https://media-cdn.tripadvisor.com/media/photo-s/1b/9a/41/f6/la-margherita-cotta-nel.jpg"),
            Restaurant(id: "5", name: "Liolà", image: "https://media-cdn.tripadvisor.com/media/photo-s/17/0f/0d/f9/gran-frutti-di-mare-su.jpg"),
            Restaurant(id: "6", name: "Pizza Telefono", image: "https://just-eat-prod-eu-res.cloudinary.com/image/upload/c_fill,d_it:cuisines:pizza-0.jpg,f_auto,q_auto,w_500/v1/it/restaurants/208090.jpg")
        ]
    }
    
    static var nextToYou: [Restaurant] {
        return [
            Restaurant(id: "7", name: "Mezzogrammo", image: "https://media-cdn.tripadvisor.com/media/photo-s/1b/9a/41/f6/la-margherita-cotta-nel.jpg"),
            Restaurant(id: "8", name: "Liolà", image: "https://media-cdn.tripadvisor.com/media/photo-s/17/0f/0d/f9/gran-frutti-di-mare-su.jpg"),
            Restaurant(id: "9", name: "Pizza Telefono", image: "https://just-eat-prod-eu-res.cloudinary.com/image/upload/c_fill,d_it:cuisines:pizza-0.jpg,f_auto,q_auto,w_500/v1/it/restaurants/208090.jpg")
        ]
    }
}

struct RestaurantData {
    let main: [Restaurant]
    let nextToYou: [Restaurant]
    let lastViewed: [Restaurant]

}
