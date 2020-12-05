//
//  AppCoordinator.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 05/12/20.
//

import UIKit

class AppCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    private let services: Services
    var window: UIWindow
    
    init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
    }
    
    func start() {
        
        let homeCoordinator = HomeCoordinator(services: services, window: window)
        coordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
}
