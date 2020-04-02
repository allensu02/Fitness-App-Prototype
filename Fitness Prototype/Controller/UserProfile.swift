//
//  UserProfile.swift
//  Fitness Prototype
//
//  Created by Allen Su on 4/1/20.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import Foundation

class UserProfile {
    var age: Int = -1
    var gender: String = ""
    var height: Int = -1
    var weight: Int = -1
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
    //var disability: String
    
    init (age: Int, gender: String, height: Int, weight: Int, firstName: String, lastName: String, email: String, password: String) {
        self.age = age
        self.gender = gender
        self.height = height
        self.weight = weight
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        //self.disability = disability
    }
}
