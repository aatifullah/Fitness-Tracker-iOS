//
//  MealViewController.swift
//  Mkuraish-Fitness Tracker
//
//  Created by Aatif Ullah on 3/14/21.
//

import UIKit

extension String {
    var isNumber : Bool {
        return Double(self) != nil
    }
}

class MealViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var receivedTopic: [String : String]?
    var receivedMeals: [Meal]?
    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var mealTableView: UITableView!
    @IBOutlet weak var topicDetail: UILabel!
    @IBOutlet weak var topicTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealTableView.delegate = self
        mealTableView.dataSource = self
        mealTableView.rowHeight = UITableView.automaticDimension
        mealTableView.estimatedRowHeight = UITableView.automaticDimension
        
        mealTableView.tableFooterView = UIView(frame: .zero)
        mealTableView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)

        // Do any additional setup after loading the view.
    }
    // Enter
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedMeals!.count
    }
    // Enter
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meal = receivedMeals?[indexPath.row]
        let cell : MealTableViewCell = self.mealTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MealTableViewCell
        cell.mealLabel.text = meal!.food.capitalized as String
        cell.quantityLabel.text = String(meal!.amount)
        cell.caloriesLabel.text = String(meal!.calories)
                
        // add boderwidth and color
        cell.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        cell.layer.borderWidth = 6
        cell.clipsToBounds = true
        return cell
    }
    
    // delete table cell swipe to the left
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            self.receivedMeals?.remove(at: indexPath.row)
            self.updateMainMealsList()
            self.mealTableView.deleteRows(at: [indexPath], with: .fade)
            print("----- DONE: removed CELL")
        }
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(named: "delete.png")
        
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            self.editMeal(indexPath: indexPath)
            completion(true)
        }
        editAction.backgroundColor = .lightGray
        editAction.image = UIImage(named: "pen.png")
        
        
        let configuration = UISwipeActionsConfiguration(actions: [editAction, deleteAction])
        configuration.performsFirstActionWithFullSwipe = false

        return configuration
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let topic = receivedTopic {
            for (name, detail) in topic {
                // print(name)
                topicTitle.text = name
                topicDetail.text = detail
            }
        }

    }
    
    @IBAction func addMeal(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add New Meal", message: "Insert food, quantity & calories.", preferredStyle: .alert)
        // food
        alert.addTextField { (text) in
            text.placeholder = "Food -> ex. Pizza"
            text.font = UIFont(name: "Kohinoor Bangla", size: 14)
        }
        
        // quantity
        alert.addTextField{(text) in
            text.placeholder = "Quantity -> ex. 2 "
            text.keyboardType = .numberPad
            text.font = UIFont(name: "Kohinoor Bangla", size: 14)
        }
        
        // calories
        alert.addTextField{(text) in
            text.placeholder = "Calroies -> ex. 300"
            text.keyboardType = .numberPad
            text.font = UIFont(name: "Kohinoor Bangla", size: 14)
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in print("cancel")})

        let add = UIAlertAction(title: "Add", style: .destructive) { (_) -> Void in
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in self.addMeal(UIButton())})
            
            if let food = alert.textFields?[0], let amount = alert.textFields?[1], let calories = alert.textFields?[2] {
                print(amount.text!.isNumber)
                
                if food.text!.count > 20 {
                    self.alertWarning(message: "\"Food\" (1st field) length can't be more than \"20\"", action: okAction)
                                    
                 } else if amount.text!.isNumber == false {
                    self.alertWarning(message: "\"Quantity\" (2nd field) must be NUMBER!", action: okAction)
                                    
                 } else if calories.text!.isNumber == false {
                    self.alertWarning(message: "\"Calories\" (3rd field) must be NUMBER!", action: okAction)
                                    
                 } else if food.text! == "" || amount.text! == "" || calories.text! == "" {
                    print("ONE OR MORE IS EMPTY")
                    self.alertWarning(message: "Must fill out all 3 fields.", action: okAction)
                        
                } else {
//                    let food = alert.textFields![0].text!
//                    let amount = Int(alert.textFields![1].text!)!
//                    let calories = Int(alert.textFields![2].text!)!
                    let mealType = self.getMealType()
                    let newMeal = Meal(food: food.text!, mealType: mealType, amount: Int(amount.text!)!, calories: Int(calories.text!)!)
                    self.addToCell(newMeal)
                    self.updateMainMealsList()
                }
            }
            

            
        }

        let actions: [UIAlertAction] = [cancel, add]
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    func editMeal(indexPath: IndexPath) {
        var meal = self.receivedMeals![indexPath.row]
        
        let alert = UIAlertController(title: "Edit meal", message: "Edit food, quantity & calories.", preferredStyle: .alert)
        
        // food
        alert.addTextField { (text) in
            text.placeholder = "Food -> ex. waffles"
            text.font = UIFont(name: "Kohinoor Bangla", size: 14)
            text.text = meal.food
        }
        
        // quantity
        alert.addTextField{(text) in
            text.placeholder = "Quantity -> ex. 2 "
            text.keyboardType = .numberPad
            text.font = UIFont(name: "Kohinoor Bangla", size: 14)
            text.text = String(meal.amount)
        }
        
        // calories
        alert.addTextField{(text) in
            text.placeholder = "Calroies -> ex. 640"
            text.keyboardType = .numberPad
            text.font = UIFont(name: "Kohinoor Bangla", size: 14)
            text.text = String(meal.calories)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in print("cancel")})

        let add = UIAlertAction(title: "Update", style: .destructive) { (_) -> Void in
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in self.editMeal(indexPath: indexPath)})
            
            if let food = alert.textFields?[0], let amount = alert.textFields?[1], let calories = alert.textFields?[2] {
                
                if food.text!.count > 20 {
                    self.alertWarning(message: "\"Food\" (1st field) length can't be more than \"20\"", action: okAction)
                                    
                 } else if amount.text!.isNumber == false {
                     self.alertWarning(message: "\"Quantity\" (2nd field) must be NUMBER!", action: okAction)
                                    
                 } else if calories.text!.isNumber == false {
                     self.alertWarning(message: "\"Calories\" (3rd field) must be NUMBER!", action: okAction)
                                    
                 } else if food.text! == "" || amount.text! == "" || calories.text! == "" {
                    self.alertWarning(message: "Must fill out all 3 fields.", action: okAction)
                        
                } else {
                    let mealType = self.getMealType()
                    meal = Meal(food: food.text!, mealType: mealType, amount: Int(amount.text!)!, calories: Int(calories.text!)!)
                    self.updateToCell(meal, indexPath.row)
                    self.updateMainMealsList()
                }
            }
            

            
        }

        let actions: [UIAlertAction] = [cancel, add]
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func addToCell(_ newMeal: Meal) -> Void {
        let index = 0
        self.receivedMeals?.insert(newMeal, at: index)

        let indexPath = IndexPath(row: index, section: 0)
        self.mealTableView.insertRows(at: [indexPath], with: .left
        )
    }
    
    func updateToCell(_ newMeal: Meal, _ index : Int) -> Void {
        self.receivedMeals![index] = newMeal

        let indexPath = IndexPath(row: index, section: 0)
        self.mealTableView.reloadRows(at: [indexPath], with: .top)

    }
    
    func alertWarning(message : String, action : UIAlertAction) -> Void {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .actionSheet)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    // update main meals list in trackViewController
    func updateMainMealsList() -> Void {
        switch self.topicTitle.text {
            case "Breakfast" :
                breakfastMeals = self.receivedMeals!
            case "Lunch" :
                lunchMeals = self.receivedMeals!
            case "Dinner" :
                dinnerMeals = self.receivedMeals!
            case .none:
                print("none")
            case .some(_):
                print("some")
        }
    }
    
    // update main meals list in mealViewController
    func getMealType() -> Meal.MealType {
        var type = Meal.MealType(rawValue: "Breakfast")
        
        switch self.topicTitle.text {
            case "Breakfast" :
                type = Meal.MealType(rawValue: "Breakfast")
            case "Lunch" :
                type = Meal.MealType(rawValue: "Lunch")
            case "Dinner" :
               type = Meal.MealType(rawValue: "Dinner")
            default:
                print("default")
        }
        
        return type!
        
    }
        


}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
