//
//  FudAppApi.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 01/12/20.
//

import Foundation
import Moya

enum FuddAppApi: TargetType {
    case getMain
    case getFavourite
    case getNextToYou
    case getLoginRequest(email: String, password: String)
    case getSignupRequest(request: SignupRequest)
    case updateProfileRequest(request: UpdateProfileRequest)
    
    var baseURL: URL {
        return URL(string: "https://private-dd2478-hellasapi.apiary-mock.com/")!
    }
    
    var path: String {
        switch self {
        case .getMain:
            return "restaurant/main"
        case .getFavourite:
            return "restaurant/favourite"
        case .getNextToYou:
            return "restaurant/nextToYou"
        case .getLoginRequest:
            return "login"
        case .getSignupRequest:
            return "signup"
        case .updateProfileRequest:
            return "updateProfile"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMain, .getFavourite, .getNextToYou, .getLoginRequest, .getSignupRequest, .updateProfileRequest:
            return .get
            
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getFavourite, .getMain, .getNextToYou, .getLoginRequest, .getSignupRequest, .updateProfileRequest:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return [:]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
