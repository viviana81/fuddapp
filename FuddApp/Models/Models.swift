//
//  Models.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 29/12/20.
//

import Foundation

enum Gender: String, Codable, CaseIterable {
    case male = "Maschio"
    case female = "Femmina"
}

enum City: String, CaseIterable {
    case palermo = "Palermo"
    case agrigento = "Agrigento"
    case trapani = "Trapani"
    case catania = "Catania"
    case messina = "Messina"
    case enna = "Enna"
    case caltanissetta = "Caltanissetta"
}

enum Province: String, CaseIterable {
    case pa = "PA"
    case ag = "AG"
    case tp = "TP"
    case ct = "CT"
    case me = "ME"
    case en = "EN"
    case cl = "CL"
}

struct LoginRequest: Codable {
    
    let email: String
    let password: String
    
}

struct SignupRequest: Codable {

    var name: String?
    var surname: String?
    var city: String?
    var province: String?
    var gender: Gender?
    var bday: Date?
    var email: String?
    var password: String?
    var confirmPwd: String?
    
}

struct UpdateProfileRequest: Codable {
    var name: String?
    var surname: String?
    var city: String?
    var province: String?
    var gender: Gender?
    var bday: Date?
    var email: String?
    var password: String?
}
