//
//  LoginCoordinator.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 28/12/20.
//

import UIKit

class LoginCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let loginViewController: LoginViewController
    private let services: Services
    let navigation: UINavigationController
    var window: UIWindow
    var onLogin: ((User) -> Void)?
    
    init(services: Services, window: UIWindow) {
        self.services = services
        self.window = window
        loginViewController = LoginViewController()
        self.navigation = UINavigationController(rootViewController: loginViewController)
        
    }
    
    func start() {
        loginViewController.delegate = self
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    
    func goToLogin(email: String, password: String) {
        services.getLoginRequest(email: email, password: password) {user, _ in
            if let user = user {
                self.onLogin?(user)
            }
        }
    }
    
    func goToSignup() {
        let signupCoordinator = SignupCoordinator(services: services, presenter: loginViewController)
        
        signupCoordinator.onTapLogin = { [weak self] user in

            self?.onLogin?(user)
        }
        
        signupCoordinator.start()
        coordinators.append(signupCoordinator)
        
    }
}
