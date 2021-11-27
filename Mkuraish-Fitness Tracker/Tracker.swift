//
//  Tracker.swift
//  Mkuraish-Fitness Tracker
//
//  Created by Aatif Ullah on 3/14/21.
//

import Foundation

class Tracker {
    enum `TrackType` : String {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
    }
}

class Meal {
    enum `MealType` : String {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
    }
    
    var food: String
    var mealType: MealType
    var amount: Int
    var calories: Int
    
    init(food: String, mealType: MealType, amount: Int, calories: Int) {
        self.food = food
        self.mealType = mealType
        self.amount = amount
        self.calories = calories
    }
    
}

let topics: [String] = [
    "Breakfast is very important meal for energy to do work!",
    "We get energy and nutrients to keep the body and brain working through the noon.",
    "Dinner completes food intake that may be inadequate during the day"
]
