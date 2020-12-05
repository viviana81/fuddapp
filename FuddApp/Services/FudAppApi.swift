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
    
    var baseURL: URL {
        return URL(string: "https://private-dd2478-hellasapi.apiary-mock.com/restaurant/")!
    }
    
    var path: String {
        switch self {
        case .getMain:
            return "main"
        case .getFavourite:
            return "favourite"
        case .getNextToYou:
            return "nextToYou"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMain, .getFavourite, .getNextToYou:
            return .get
            
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getFavourite, .getMain, .getNextToYou:
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
