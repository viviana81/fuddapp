//
//  ProfileCoordinator.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 02/01/21.
//

import UIKit

class ProfileCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    private let profileViewController: ProfileViewController
    private let navigation: UINavigationController
    private let services: Services
    private var user: User
    private let presenter: UIViewController
    private var updateProfile: UpdateProfileRequest
    
    init(services: Services, presenter: UIViewController, user: User) {
        self.services = services
        self.profileViewController = ProfileViewController(user: user)
        self.navigation = UINavigationController(rootViewController: profileViewController)
        self.user = user
        self.presenter = presenter
        updateProfile = UpdateProfileRequest()
    }
    
    func start() {
        profileViewController.delegate = self
        navigation.modalPresentationStyle = .fullScreen
        profileViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(close))
        presenter.present(navigation, animated: true, completion: nil)
    }
    
    @objc
    private func close() {
        presenter.dismiss(animated: true, completion: nil)
    }
}

extension ProfileCoordinator: ProfileViewControllerDelegate {
    
    func saveProfile(name: String, surname: String, city: String, province: String, gender: Gender, bday: String, email: String, pwd: String) {
       
        updateProfile.name = name
        updateProfile.surname = surname
        updateProfile.bday = DateFormatter.APIDateFormatter.date(from: bday)
        updateProfile.city = city
        updateProfile.province = province
        updateProfile.gender = gender
        updateProfile.email =  email
        
        services.updateProfileRequest(request: updateProfile) { [weak self] user, _ in
            if let user = user {
                UserDefaultsConfig.user = user
                self?.user = user
            }
            
            
            self?.presenter.dismiss(animated: true, completion: nil)
        }
    }
}
