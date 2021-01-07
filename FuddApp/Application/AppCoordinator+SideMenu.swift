//
//  AppCoordinator+SideMenu.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 29/12/20.
//

import UIKit

extension AppCoordinator: SideMenuViewControllerDelegate {
   
    func goToLogout() {
        UserDefaultsConfig.user = nil
        self.start()
    }
    
    func goToProfile() {
        
        guard let user = UserDefaultsConfig.user, let presenter = UIApplication.topViewController()
        else { return }
        
        coordinators.removeAll()
        presenter.slideMenuController()?.closeLeft()
        let profileCoordinator = ProfileCoordinator(services: services, presenter: presenter, user: user)
        coordinators.append(profileCoordinator)
        profileCoordinator.start()
    }
}
