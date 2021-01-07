//
//  ProfileViewController.swift
//  FuddApp
//
//  Created by Viviana Capolvenere on 02/01/21.
//

import UIKit

protocol ProfileViewControllerDelegate: class {
    
    func saveProfile(name: String, surname: String, city: String, province: String, gender: Gender, bday: String, email: String, pwd: String)
}

class ProfileViewController: UIViewController {
    
    enum ProfileStatus {
        case edit
        case view
        
    }
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var surnameTxtField: UITextField!
    @IBOutlet weak var cityTxtField: UITextField!
    @IBOutlet weak var provinceTxtField: UITextField!
    @IBOutlet weak var genderTxtField: UITextField!
    @IBOutlet weak var bdayTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var pwdTxtField: UITextField!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet var textfields: [UITextField]!
    
    weak var delegate: ProfileViewControllerDelegate?
    
    private var status: ProfileStatus = .view {
        didSet {
           updateState()
        }
    }
    
    private let user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var genderPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    lazy var cityPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    lazy var provincePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    lazy var bdayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(onDateChange), for: .valueChanged)
        
        return picker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Modifica il tuo profilo"
        nameTxtField.text = user.name
        surnameTxtField.text = user.surname
        cityTxtField.text = user.city
        provinceTxtField.text = user.province
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        bdayTxtField.text = formatter.string(from: user.bday)
        emailTxtField.text = user.email
        genderTxtField.text = user.gender.rawValue

        genderTxtField.inputView = genderPicker
        cityTxtField.inputView = cityPicker
        provinceTxtField.inputView = provincePicker
        bdayTxtField.inputView = bdayPicker
        updateState()
        
    }
    
    @objc
    func onDateChange(_ picker: UIDatePicker) {
        let formatter = DateFormatter()
        let bday = bdayPicker.date
        formatter.dateFormat = "dd/MMMM/YYYY"
        bdayTxtField.text = formatter.string(from: bday)
    }
    
    func updateState() {
        switch status {
        case .edit:
            changeButton.setTitle("Salva", for: .normal)
            setTxtField(true)
        case .view:
            changeButton.setTitle("Modifica", for: .normal)
            setTxtField(false)
        }
    }
    
    @IBAction func changeAction() {
        
        if status == .view {
            status = .edit
            nameTxtField.becomeFirstResponder()
        } else {
            status = .view
            guard let name = nameTxtField.text,
                  let surname = surnameTxtField.text,
                  let gender = genderTxtField.text,
                  let bday = bdayTxtField.text,
                  let city = cityTxtField.text,
                  let province = provinceTxtField.text,
                  let email = emailTxtField.text,
                  let pwd = pwdTxtField.text else { return }
            
            delegate?.saveProfile(name: name, surname: surname, city: city, province: province, gender: Gender(rawValue: gender)!, bday: bday, email: email, pwd: pwd)
            
        }
    }
    
    private func setTxtField(_ active: Bool) {
        for textfield in textfields {
            textfield.isUserInteractionEnabled = active
            
            textfield.borderStyle = active ? .roundedRect : .none
        }
    }
}

extension ProfileViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == genderPicker {
            return Gender.allCases.count
        } else if pickerView == cityPicker {
            return City.allCases.count
        } else {
            return Province.allCases.count
        }
    }
}

extension ProfileViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == genderPicker {
            return Gender.allCases[row].rawValue
        } else if pickerView == cityPicker {
            return City.allCases[row].rawValue
        } else {
            return Province.allCases[row].rawValue
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == genderPicker {
           let gender = Gender.allCases[row].rawValue
            genderTxtField.text = gender
        } else if pickerView == cityPicker {
            let city = City.allCases[row].rawValue
            cityTxtField.text = city
        } else {
            let province =  Province.allCases[row].rawValue
            provinceTxtField.text = province
        }
        
        self.view.endEditing(true)
    }
}
