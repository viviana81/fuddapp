//
//  LoginViewController.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 28/12/20.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    func goToLogin(email: String, password: String)
    func goToSignup()
}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var pswTxtField: UITextField!
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func login() {
        guard let email = emailTxtField.text, !emailTxtField.text!.isEmpty,
              let password = pswTxtField.text, !pswTxtField.text!.isEmpty else { return }
        delegate?.goToLogin(email: email, password: password)
    }
    
    @IBAction func signup() {
        delegate?.goToSignup()
    }
}
