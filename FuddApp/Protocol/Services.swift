//
//  Services.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 01/12/20.
//

import Foundation

protocol Services {
    func getMain(completion: @escaping ([Restaurant]?, Error?) -> Void)
    func getFavourite(completion: @escaping ([Restaurant]?, Error?) -> Void)
    func getNexToYou(completion: @escaping ([Restaurant]?, Error?) -> Void)
    func getLoginRequest(email: String, password: String, completion: @escaping (User?, Error?) -> Void)
    func signup(request: SignupRequest, completion: @escaping (User?, Error?) -> Void)
    func updateProfileRequest(request: UpdateProfileRequest, completion: @escaping (User?, Error?) -> Void)
}
