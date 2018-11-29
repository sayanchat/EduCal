//
//  TutorTableViewController.swift
//  EduCal
//
//  Created by Sayan Chatterjee on 11/28/18.
//  Copyright © 2018 Sayan Chatterjee. All rights reserved.
//

import UIKit

class TutorTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tutorTableView: UITableView!
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
