//
//  AppCoordinator.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 05/12/20.
//

import UIKit
import SlideMenuControllerSwift

class AppCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let services: Services
    var window: UIWindow
    var sideMenu: SideMenuViewController?
    
    init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
    }
    
    func start() {
        
        coordinators.removeAll()
        
        guard let user = UserDefaultsConfig.user  else {
           
            let loginCoordinator = LoginCoordinator(services: services, window: window)
            loginCoordinator.onLogin = { [weak self]  user in
                UserDefaultsConfig.user = user
                self?.start()
            }
            
            coordinators.append(loginCoordinator)
            loginCoordinator.start()
            return
        }
        
        self.sideMenu = SideMenuViewController(withDelegate: self, user: user)
        
        let homeCoordinator = HomeCoordinator(services: services, window: window, user: user, sideMenu: sideMenu!)
        coordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
}
       
