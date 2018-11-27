//
//  UserProfile.swift
//  EduCal
//
//  Created by Sayan Chatterjee on 11/27/18.
//  Copyright © 2018 Sayan Chatterjee. All rights reserved.
//

import UIKit

class UserProfile {
    let name: String
    let major: String
    let year: String
    let email: String
    let number: String
    let location: String
    
    init(name: String, major: String, year: String, location: String, email: String, number: String) {
        self.name = name
        self.major = major
        self.year = year
        self.location = location
        self.email = email
        self.number = number
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "major": major,
            "year": year,
            "location": location,
            "email": email,
            "number": number
        ]
    }
}
