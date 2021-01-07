//
//  SignupCoordinator.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 30/12/20.
//

import UIKit

class SignupCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    let signupStep1: SignupStep1ViewController
    private let presenter: UIViewController
    private let services: Services
    private var signupRequest: SignupRequest
    var onTapLogin: ((User) -> Void)?
    
    enum Step {
        case step1
        case step2(name: String, surname: String, city: String, province: String)
        case step3(gender: Gender, bday: String, email: String, pwd: String, confirmPwd: String)
    }
    
    init(services: Services, presenter: UIViewController) {
        self.services = services
        self.presenter = presenter
        signupStep1 = SignupStep1ViewController()
        signupRequest = SignupRequest()
    }
    
    func start() {
        signupStep1.delegate = self
        
        goTo(step: .step1)
    }
    
    func goTo(step: Step) {
        switch step {
        case .step1:
            presenter.navigationController?.pushViewController(signupStep1, animated: true)
        case .step2(let name, let surname, let city, let province):
            
            signupRequest.name = name
            signupRequest.surname = surname
            signupRequest.city = city
            signupRequest.province = province
            let signupStep2 = SignupStep2ViewController()
            signupStep2.delegate = self
            presenter.navigationController?.pushViewController(signupStep2, animated: true)
            
        case .step3(let gender, let bday, let email, let pwd, let confirmPwd):
            signupRequest.gender = gender
            signupRequest.bday = DateFormatter.APIDateFormatter.date(from: bday)
            signupRequest.email = email
            signupRequest.password = pwd
            signupRequest.confirmPwd = confirmPwd
        
            services.signup(request: signupRequest) { user, _ in
                if let user = user {
                    self.onTapLogin?(user)
                } else {
                    return
                }
            }
        }
    }
}

extension SignupCoordinator: SignupStep1ViewControllerDelegate {
    
    func goToStep2(name: String, surname: String, city: String, province: String) {
        
        goTo(step: .step2(name: name, surname: surname, city: city, province: province))
    }
}

extension SignupCoordinator: SignupStep2ViewControllerDelegate {
    func goToLogin(gender: String, bday: String, email: String, pwd: String, confirmPwd: String) {
        
        goTo(step: .step3(gender: Gender(rawValue: gender)!, bday: bday, email: email, pwd: pwd, confirmPwd: confirmPwd))
    }
}
