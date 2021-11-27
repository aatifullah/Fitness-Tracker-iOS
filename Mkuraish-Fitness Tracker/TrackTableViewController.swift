//
//  TrackTableViewController.swift
//  Mkuraish-Fitness Tracker
//
//  Created by Aatif Ullah on 3/14/21.
//

import UIKit

let trackTopics = [
    "Breakfast",
    "Lunch",
    "Dinner"
]

let meal1 = Meal(food: "Burger", mealType: .breakfast, amount: 1, calories: 180)
let meal2 = Meal(food: "Pizza with Coke", mealType: .lunch, amount: 1, calories: 720)
let meal3 = Meal(food: "Noodles", mealType: .dinner, amount: 1, calories: 550)

var breakfastMeals : [Meal]? = [ meal1 ]
var lunchMeals : [Meal]? = [ meal2 ]
var dinnerMeals : [Meal]? = [ meal3 ]

class TrackTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return topics.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        var sentTopic: [String : String ] = [:]
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
  
            if let mealViewController = segue.destination as? MealViewController {
                
                if indexPath.row == 0 {
                    sentTopic["Breakfast"] = topics[indexPath.row]
                    mealViewController.receivedTopic = sentTopic
                    mealViewController.receivedMeals = breakfastMeals
                    
                } else if indexPath.row == 1 {
                    sentTopic["Lunch"] = topics[indexPath.row]
                    mealViewController.receivedTopic = sentTopic
                    mealViewController.receivedMeals = lunchMeals
                    
                } else if indexPath.row == 2 {
                    sentTopic["Dinner"] = topics[indexPath.row]
                    mealViewController.receivedTopic = sentTopic
                    mealViewController.receivedMeals = dinnerMeals
                    
                    
                }
                
            }
            
         }
        
    
    }
    

}
