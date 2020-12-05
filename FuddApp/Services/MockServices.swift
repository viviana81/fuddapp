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
    
    let decoder = JSONDecoder()
    
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
}
