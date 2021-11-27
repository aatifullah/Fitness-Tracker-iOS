//
//  User.swift
//  Mkuraish-Fitness Tracker
//
//  Created by Aatif Ullah on 3/14/21.
//

import Foundation

class User {
    enum `Gender` : String {
        case male = "Male"
        case female = "Female"
    }
    
    var name : String
    var gender : Gender
    var age : Int
    var heightFeet: Int
    var heightInches: Int
    var weight: Int
    var goalWeight: Int
    var bmi: Double
    
    init(name: String, gender:Gender, age: Int, heightFeet: Int, heightInches: Int, weight: Int, goalWeight: Int, bmi: Double ) {
        self.name = name
        self.gender = gender
        self.age = age
        self.heightFeet = heightFeet
        self.heightInches = heightInches
        self.weight = weight
        self.goalWeight = goalWeight
        self.bmi = bmi
        
    }
}

let defaultUser = User(name: "Steve Jobs", gender: .male, age: 55, heightFeet: 6, heightInches: 1, weight: 150, goalWeight: 120, bmi: 24.4)
