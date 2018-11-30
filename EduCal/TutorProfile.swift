//
//  TutorProfile.swift
//  EduCal
//
//  Created by Sayan Chatterjee on 11/29/18.
//  Copyright © 2018 Sayan Chatterjee. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class TutorProfile {
    let name: String
    let major: String
    let year: String
    let email: String
    let number: String
    let location: String
    let course: String
    let bio: String
    
    init(name: String, major: String, year: String, location: String, email: String, number: String, course: String, bio: String) {
        self.name = name
        self.major = major
        self.year = year
        self.location = location
        self.email = email
        self.number = number
        self.course = course
        self.bio = bio
    }
    init? (snapshot: DataSnapshot) {
        guard
        let value = snapshot.value as? [String: AnyObject],
        let name = value["name"] as? String,
        let major = value["major"] as? String,
        let year = value["year"] as? String,
        let location = value["location"] as? String,
        let email = value["email"] as? String,
        let number = value["number"] as? String,
        let course = value["course"] as? String,
        let bio = value["bio"] as? String else {
            return nil}
        self.name = name
        self.major = major
        self.year = year
        self.location = location
        self.email = email
        self.number = number
        self.course = course
        self.bio = bio
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "major": major,
            "year": year,
            "location": location,
            "email": email,
            "number": number,
            "course": course,
            "bio": bio
        ]
    }
}
