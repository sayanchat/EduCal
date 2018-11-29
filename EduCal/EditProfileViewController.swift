//
//  EditProfileViewController.swift
//  EduCal
//
//  Created by Lily Bhattacharjee on 11/28/18.
//  Copyright © 2018 Sayan Chatterjee. All rights reserved.
//

import UIKit
import Firebase

class EditProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var name: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var major: UITextField!
    @IBOutlet var phoneNum: UITextField!
    @IBOutlet var year: UIPickerView!
    @IBOutlet var location: UITextField!
    @IBOutlet var updateChanges: UIButton!
    
    var yearOptions = ["Freshman", "Sophomore", "Junior", "Senior", "Graduate"]
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let user = Auth.auth().currentUser
        updateChanges.setTitle("Update Changes", for: .normal)
        ref = Database.database().reference()
        
        year.delegate = self
        year.dataSource = self
    }
    
    @IBAction func pushChanges(_ sender: Any) {
        let userID = Auth.auth().currentUser!.uid
        let key = ref.child("users").child(userID).key
        let values = [
            "name": name.text,
            "major": major.text,
            "location": location.text,
            "email": email.text,
            "number:": phoneNum.text
        ]
        ref.root.child("users").child(userID).updateChildValues(values)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return yearOptions[row]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
