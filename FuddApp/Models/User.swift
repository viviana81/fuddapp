//
//  User.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 28/12/20.
//

import Foundation

struct User: Codable {
    
    let name: String
    let surname: String
    let bday: Date
    let gender: Gender
    let city: String
    let province: String
    let email: String
}
