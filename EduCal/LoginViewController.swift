//
//  LoginViewController.swift
//  EduCal
//
//  Created by Sayan Chatterjee on 11/27/18.
//  Copyright © 2018 Sayan Chatterjee. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTF.delegate = self
        self.passwordTF.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    var username = ""
    var password = ""
    
    @IBAction func loginButton(_ sender: Any) {
        guard let userText = usernameTF.text else { return }
        guard let passText = passwordTF.text else { return }
        
        if userText == "" || passText == "" {
            let alertController = UIAlertController(title: "Login Error", message: "Please enter a username and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            Auth.auth().signIn(withEmail: userText, password: passText) { (user, error) in
                if error != nil {
                    let alertController = UIAlertController(title: "Log In Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: "loginToMain", sender: self)
                }
            }
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        performSegue(withIdentifier: "loginToSignUp", sender: self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.usernameTF {
            if textField.text != nil {
                self.username = textField.text!
            }
        } else {
            if textField.text != nil {
                self.password = textField.text!
            }
        }
    }
}
