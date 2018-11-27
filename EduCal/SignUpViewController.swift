//
//  SignUpViewController.swift
//  EduCal
//
//  Created by Sayan Chatterjee on 11/27/18.
//  Copyright © 2018 Sayan Chatterjee. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return year.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return year[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        yearSelected = year[row]
    }
    
    var year: [String] = [String]()
    var yearSelected: String = ""
    var email = ""
    var username = ""
    var password = ""
    var major = ""
    var number = ""
    var location = ""
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userMajor: UITextField!
    @IBOutlet weak var userNumber: UITextField!
    @IBOutlet weak var userLocation: UITextField!
    
    @IBOutlet weak var userYear: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userName.delegate = self
        self.userEmail.delegate = self
        self.userPassword.delegate = self
        self.userMajor.delegate = self
        self.userNumber.delegate = self
        self.userLocation.delegate = self
        self.userYear.delegate = self
        self.userYear.dataSource = self
        year = ["Freshman", "Sophomore", "Junior", "Senior", "Graduate"]
    }
    
    @IBAction func createProfile(_ sender: Any) {
        guard let emailText = userEmail.text else { return }
        guard let passwordText = userPassword.text else { return }
        guard let usernameText = userName.text else { return }
        guard let majorText = userMajor.text else { return }
        guard let locationText = userLocation.text else { return }
        guard let numberText = userNumber.text else { return }
        
        if emailText == "" || passwordText == "" || usernameText == "" || majorText == "" || locationText == "" || numberText == "" || yearSelected == "" {
            let alertController = UIAlertController(title: "Form Error.", message: "Please fill in form completely.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: emailText, password: passwordText) { (user, error) in
                if error == nil {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = usernameText
                    changeRequest?.commitChanges { (error) in
                        if error == nil  {
                            let accountCreatedController = UIAlertController(title: "Success.", message: "The account has been created.", preferredStyle: .alert)
                            let successAction = UIAlertAction(title: "OK.", style: .default) { (action:UIAlertAction) in
                                self.performSegue(withIdentifier: "signUpToLogin", sender: self)
                            }
                            accountCreatedController.addAction(successAction)
                            self.present(accountCreatedController, animated: true, completion: nil)
                        }
                    }
                    let childRef = Database.database().reference(withPath: "users")
                    let profile = UserProfile(name: usernameText, major: majorText, year: self.yearSelected, location: locationText, email: emailText, number: numberText)
                    childRef.child((Auth.auth().currentUser?.uid)!).setValue(profile.toAnyObject())
                } else {
                    let alertController = UIAlertController(title: "Sign Up Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.userName {
            if textField.text != nil {
                self.username = textField.text!
            }
        } else if textField == self.userPassword {
            if textField.text != nil {
                self.password = textField.text!
            }
        } else if textField == self.userEmail {
            if textField.text != nil {
                self.email = textField.text!
            }
        } else if textField == self.userMajor {
            if textField.text != nil {
                self.major = textField.text!
            }
        } else if textField == self.userNumber {
            if textField.text != nil {
                self.number = textField.text!
            }
        } else {
            if textField.text != nil {
                self.location = textField.text!
            }
        }
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        performSegue(withIdentifier: "signUpToLogin", sender: self)
    }
}
