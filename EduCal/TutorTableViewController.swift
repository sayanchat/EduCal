//
//  TutorTableViewController.swift
//  EduCal
//
//  Created by Sayan Chatterjee on 11/28/18.
//  Copyright © 2018 Sayan Chatterjee. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class TutorTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var num: Int = 0
    var tutors: [TutorProfile] = []
    let ref = Database.database().reference()
    @IBOutlet weak var tutortable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.child("tutors").observe(.value, with: {(snapshot: DataSnapshot!) in
            var newTutors: [TutorProfile] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot{
                    let newTutor = TutorProfile(snapshot: snapshot)
                    newTutors.append(newTutor!)
                }
            }
            self.tutors = newTutors
            self.tutortable.reloadData()
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tutors)
        return tutors.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tutortable.dequeueReusableCell(withIdentifier: "TutorCell", for: indexPath) as? TutorCell
        let tutorPerson = tutors[indexPath.row]
        
        cell?.nameLabel.text = tutorPerson.name
        cell?.bioLabel.text = tutorPerson.bio
        cell?.majorLabel.text = tutorPerson.major
        cell?.yearLabel.text = tutorPerson.year
        cell?.courseLabel.text = tutorPerson.course
        cell?.emailLabel.text = tutorPerson.email
        cell?.locationLabel.text = tutorPerson.location
        cell?.numberLabel.text = tutorPerson.number
        
        return cell!
    }
    
    
    
    @IBAction func addRequest(_ sender: Any) {
        performSegue(withIdentifier: "tutorListToRequest", sender: self)
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
