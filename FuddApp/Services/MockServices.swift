//
//  MockServices.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 03/12/20.
//

import Foundation
import Moya

struct MockServices: Services {
    
    let provider = MoyaProvider<FuddAppApi>()
    
    let decoder: JSONDecoder
    
    init() {
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.APIDateFormatter)
    }
    
    func getMain(completion: @escaping ([Restaurant]?, Error?) -> Void) {
        provider.request(.getMain) { result in
            switch result {
            case.success(let response):
                let main = try? self.decoder.decode([Restaurant].self, from: response.data)
                completion(main, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getFavourite(completion: @escaping ([Restaurant]?, Error?) -> Void) {
        provider.request(.getFavourite) { result in
            switch result {
            case.success(let response):
                let favouriteRestaurants = try? self.decoder.decode([Restaurant].self, from: response.data)
                completion(favouriteRestaurants, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getNexToYou(completion: @escaping ([Restaurant]?, Error?) -> Void) {
        provider.request(.getNextToYou) { result in
            switch result {
            case.success(let response):
                let nextToYou = try? self.decoder.decode([Restaurant].self, from: response.data)
                completion(nextToYou, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getLoginRequest(email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        
        provider.request(.getLoginRequest(email: email, password: password)) { result in
            switch result {
            case.success(let response):
                let user = try! self.decoder.decode(User.self, from: response.data)
                completion(user, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func signup(request: SignupRequest, completion: @escaping (User?, Error?) -> Void) {
        provider.request(.getSignupRequest(request: request)) { result in
            switch result {
            case.success(let response):
                let user = try? self.decoder.decode(User.self, from: response.data)
                completion(user, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func updateProfileRequest(request: UpdateProfileRequest, completion: @escaping (User?, Error?) -> Void) {
        provider.request(.updateProfileRequest(request: request)) { result in
            switch result {
            case.success(let response):
                let user = try? self.decoder.decode(User.self, from: response.data)
                completion(user, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
