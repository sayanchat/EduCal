//
//  ProfileViewController.swift
//  EduCal
//
//  Created by Lily Bhattacharjee on 11/28/18.
//  Copyright © 2018 Sayan Chatterjee. All rights reserved.
//

import Firebase
import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var email: String = ""
    var location: String = ""
    var major: String = ""
    var name: String = ""
    var number: String = ""
    
    var displayedData: [String] = []
    var displayedName: [String] = ["Name:", "Major:", "Location:", "Email:", "Phone Num:"]
    
    var ref: DatabaseReference!

    @IBOutlet var userProfile: UITableView!
    @IBOutlet var editProfile: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfile.reloadData()
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
        let user = Auth.auth().currentUser
        email = user?.email as! String
        ref.child("users").child(user?.uid as! String).observeSingleEvent(of: .value, with: {(snapshot) in
            self.location = (snapshot.value as! NSDictionary)["location"] as! String
            self.major = (snapshot.value as! NSDictionary)["major"] as! String
            self.name = (snapshot.value as! NSDictionary)["name"] as! String
            self.number = (snapshot.value as! NSDictionary)["number"] as! String
            self.displayedData = [self.name, self.major, self.location, self.email, self.number]
            self.userProfile.reloadData();
        })
        
        print("location: " + self.location)
        
        editProfile.setTitle("Edit Profile", for: .normal)
        
        self.userProfile.delegate = self
        self.userProfile.dataSource = self
    }
    
    @IBAction func editProfilePressed(_ sender: Any) {
        performSegue(withIdentifier: "editProfile", sender: sender)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row: Int = indexPath.row
        let cell = userProfile.dequeueReusableCell(withIdentifier: "profileData", for: indexPath) as! ProfileTableViewCell
        cell.propertyName.text = displayedName[row]
        cell.propertyValue.text = displayedData[row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
