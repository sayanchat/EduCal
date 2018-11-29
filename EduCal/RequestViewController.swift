//
//  RequestViewController.swift
//  EduCal
//
//  Created by Sayan Chatterjee on 11/28/18.
//  Copyright © 2018 Sayan Chatterjee. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

class RequestViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return courses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return courses[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        classSelected = courses[row]
    }
    
    var classSelected: String = ""
    var bioText: String = ""
    
    @IBOutlet weak var coursePicker: UIPickerView!
    @IBOutlet weak var userBio: UITextField!
    
    var courses: [String] = [String]()
    var name: String?
    var major : String?
    var year: String?
    var location: String?
    var email: String?
    var number: String?
    
    let tutorRef = Database.database().reference(withPath: "tutors")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userBio.delegate = self
        self.coursePicker.delegate = self
        self.coursePicker.dataSource = self
        courses = ["CS 61A", "CS 61B", "CS 61C", "CS 70", "EE 16A", "EE 16B", "Physics 7A", "Physics 7B", "Math 1A", "Math 1B", "Math 53", "Math 54", "Math 55", "Stat C8", "Stat C88", "Stat 20", "Stat 21", "Stat C100", "Engineering 7", "Engineering 25", "Biology 1A + L", "Biology 1B", "Chemistry 1A + L", "Chemistry 1B", "Chemistry 3A + L", "Chemistry 3B + L"]
    }
    
    @IBAction func createRequest(_ sender: Any) {
        guard let skillText = userBio.text else { return }
        if skillText == "" || classSelected == "" {
            let alertController = UIAlertController(title: "Form Error.", message: "Please fill in form completely.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        } else {
            let ref = Database.database().reference()
            let user = Auth.auth().currentUser
            ref.child("users").child(user?.uid as! String).observeSingleEvent(of: .value, with: {(snapshot) in
                self.location = (snapshot.value as! NSDictionary)["location"] as! String
                self.major = (snapshot.value as! NSDictionary)["major"] as! String
                self.name = (snapshot.value as! NSDictionary)["name"] as! String
                self.number = (snapshot.value as! NSDictionary)["number"] as! String
                self.email = (snapshot.value as! NSDictionary)["email"] as! String
                self.year = (snapshot.value as! NSDictionary)["year"] as! String
                print(self.name, self.major, self.year)
                let profile = TutorProfile(name: self.name!, major: self.major!, year: self.year!, location: self.location!, email: self.email!, number: self.number!, course: self.classSelected, bio: skillText)
                self.tutorRef.child((Auth.auth().currentUser?.uid)!).setValue(profile.toAnyObject())
                self.performSegue(withIdentifier: "goBack", sender: self)
            })
            /*
            Database.database().reference(withPath: "users").child(user!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                self.name = (value?["name"] as? String?)!
                self.major = (value?["major"] as? String?)!
                self.year = (value?["year"] as? String?)!
                self.location = (value?["location"] as? String?)!
                self.email = (value?["email"] as? String?)!
                self.number = (value?["number"] as? String?)!
                print(self.name, self.major, self.year)
            })*/
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.userBio {
            if textField.text != nil {
                self.bioText = textField.text!
            }
        }
    }
}
