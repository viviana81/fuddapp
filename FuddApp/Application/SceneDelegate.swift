//
//  SceneDelegate.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 28/11/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    // private var coordinator: AppCoordinator?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        let home = HomeViewController()
        let navigation = UINavigationController(rootViewController: home)
        window.rootViewController = navigation
        // window.tintColor = UIColor(named: "primary")
        
        // let services = TlockFakeServices()
        // let appCoordinator = AppCoordinator(withWindow: window, services: services)
        // appCoordinator.start()
        
        // self.coordinator = appCoordinator
        self.window = window
        
        window.makeKeyAndVisible()
    }
}
