//
//  HomeCoordinator.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 05/12/20.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    let homeViewController: HomeViewController
    private let services: Services
    let navigation: UINavigationController
    var window: UIWindow
    
    init(services: Services, window: UIWindow) {
        self.services = services
        self.window = window
        homeViewController = HomeViewController()
        self.navigation = UINavigationController(rootViewController: homeViewController)
    
    }

    func start() {
    
        window.rootViewController = navigation
    }
}
