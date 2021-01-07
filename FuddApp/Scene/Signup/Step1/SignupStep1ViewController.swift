//
//  SignupStep1ViewController.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 30/12/20.
//

import UIKit

protocol SignupStep1ViewControllerDelegate: class {
    func goToStep2(name: String, surname: String, city: String, province: String)
}

class SignupStep1ViewController: UIViewController {

    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var surnameTxtField: UITextField!
    @IBOutlet weak var cityTxtField: UITextField!
    @IBOutlet weak var provinceTxtField: UITextField!
    
    weak var delegate: SignupStep1ViewControllerDelegate?
    
    lazy var cityPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    lazy var provincePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        cityTxtField.inputView = cityPicker
        provinceTxtField.inputView = provincePicker
    }
    
    @IBAction func step2() {
        guard let name = nameTxtField.text, !nameTxtField.text!.isEmpty,
              let surname = surnameTxtField.text, !surnameTxtField.text!.isEmpty,
              let city = cityTxtField.text, !cityTxtField.text!.isEmpty,
              let province = provinceTxtField.text, !provinceTxtField.text!.isEmpty else { return }
        
        delegate?.goToStep2(name: name, surname: surname, city: city, province: province)
    }
}

extension SignupStep1ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cityPicker {
            return City.allCases.count
        } else {
            return Province.allCases.count
        }
    }
}

extension SignupStep1ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == cityPicker {
            return City.allCases[row].rawValue
        } else {
            return Province.allCases[row].rawValue
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == cityPicker {
            let city = City.allCases[row].rawValue
            cityTxtField.text = city
        } else {
            let province = Province.allCases[row].rawValue
            provinceTxtField.text = province
        }
        
        self.view.endEditing(true)
    }
}
