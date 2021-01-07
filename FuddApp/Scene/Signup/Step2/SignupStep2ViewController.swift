//
//  SignupStep2ViewController.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 30/12/20.
//

import UIKit

protocol SignupStep2ViewControllerDelegate: class {
    
    func goToLogin(gender: String, bday: String, email: String, pwd: String, confirmPwd: String)
}

class SignupStep2ViewController: UIViewController {

    @IBOutlet weak var genderTxtField: UITextField!
    @IBOutlet weak var bdayTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var pwdTxtField: UITextField!
    @IBOutlet weak var confirmPwdTxtField: UITextField!
    
    weak var delegate: SignupStep2ViewControllerDelegate?
    
    lazy var genderPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    lazy var bdayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(onDateChanged), for: .valueChanged)
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        genderTxtField.inputView = genderPicker
        bdayTxtField.inputView = bdayPicker
    }
    
    @IBAction func login() {
        guard let gender = genderTxtField.text, !genderTxtField.text!.isEmpty,
              let bday = bdayTxtField.text, !bdayTxtField.text!.isEmpty,
              let email = emailTxtField.text, !emailTxtField.text!.isEmpty,
              let pwd = pwdTxtField.text, !pwdTxtField.text!.isEmpty,
              let confirmPwd = pwdTxtField.text, !confirmPwdTxtField.text!.isEmpty else { return }
        
        guard pwd == confirmPwd  else { return }
        delegate?.goToLogin(gender: gender, bday: bday, email: email, pwd: pwd, confirmPwd: confirmPwd)
    }
    
    @objc
    func onDateChanged(_ picker: UIDatePicker) {
        let formatter = DateFormatter()
        let bday = picker.date
        formatter.dateFormat = "dd/MM/YYYY"
        bdayTxtField.text = formatter.string(from: bday)
    }
}

extension SignupStep2ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Gender.allCases.count
    }
}

extension SignupStep2ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Gender.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let gender = Gender.allCases[row].rawValue
        genderTxtField.text = gender
        
        self.view.endEditing(true)
    }
}
