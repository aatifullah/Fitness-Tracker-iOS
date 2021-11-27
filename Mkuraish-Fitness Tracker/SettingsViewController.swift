//
//  SettingsViewController.swift
//  Mkuraish-Fitness Tracker
//
//  Created by Aatif Ullah on 3/8/21.
//

import UIKit

let ages = ["1", "2", "3", "4", "5",
            "6", "7", "8", "9", "10",
            "11", "12", "13", "14", "15",
            "16", "17", "18", "19", "20",
            "21", "22", "23", "24", "25",
            "26", "27", "28", "29", "30",
            "31", "32", "33", "34", "35",
            "36", "37", "38", "39", "40",
            "41", "42", "43", "44", "45",
            "46", "47", "48", "49", "50",
            "51", "51", "52", "53", "54",
            "55", "56", "57", "58", "59",
            "60", "61", "62", "63", "64",
            "65", "66", "67", "68", "69",
            "70", "71", "72", "73", "74",
            "75", "76", "77", "78", "79",
            "80", "81", "82", "83", "84",
            "85", "86", "87", "88", "89",
            "90", "91", "92", "93", "94",
            "95", "96", "97", "98", "99",
            "100"]

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var user: User?

    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var nameOutlet: UITextField!
    @IBOutlet weak var genderOutlet: UISegmentedControl!
    @IBOutlet weak var agePickerOutlet: UIPickerView!
    @IBOutlet weak var feetOutlet: UITextField!
    @IBOutlet weak var inchesOutlet: UITextField!
    @IBOutlet weak var weightOutlet: UITextField!
    @IBOutlet weak var goalWeightOutlet: UITextField!
    @IBOutlet weak var bmiResult: UILabel!
    @IBOutlet weak var bmiCategoryOutlet: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = user {
            nameOutlet.text = user.name
            
            if user.gender == .male {
                genderOutlet.selectedSegmentIndex = 0
            } else {
                genderOutlet.selectedSegmentIndex = 1
            }
            
            inchesOutlet.text = String(user.heightInches)
            feetOutlet.text = String(user.heightFeet)
            weightOutlet.text = String(user.weight)
            
            var indexAge = 0
            for i in 0..<ages.count  {
                if Int(ages[i]) == user.age {
                    indexAge = i
                }
            }
            agePickerOutlet.selectRow(indexAge, inComponent: 0, animated: true)
            goalWeightOutlet.text = String(user.goalWeight)
            bmiResult.text = String(user.bmi)
            self.displayBmiCategory(user.bmi)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ages.count
    }
    
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
    forComponent component: Int)
    -> String? { return ages[row]
    }
    
    @IBAction func backToHome(_ sender: UIBarButtonItem) {
        let actionSheetController = UIAlertController(title: "WARNING", message:"No changes will be saved", preferredStyle: .actionSheet)
        let cancelAction =
            UIAlertAction(title: "Stay",
                style: .cancel,
                handler: nil)
        let okayAction =
            UIAlertAction(title: "Go back to home",
                style: .default) {
                    _ in self.dismiss(animated: true, completion: nil)
                }
        
        actionSheetController.addAction(okayAction)
        actionSheetController.addAction(cancelAction)
        present(actionSheetController, animated: true, completion: nil)
    }
    
    @IBAction func nameInput(_ sender: UITextField) {
        print(sender.text!)
        user?.name = sender.text!
    }
    
    @IBAction func genderAction(_ sender: UISegmentedControl) {
        let pickedSegment = sender.selectedSegmentIndex
        if let user = user {
            switch pickedSegment {
             case 0:
                 user.gender = .male
             case 1:
                 user.gender = .female
             default:
                 break
             }
        }
    }
    
    @IBAction func inchesInput(_ sender: UITextField) {
        let inches = inchesOutlet.text!

        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

        if (Double(inches) == nil) {
        let alert = UIAlertController(title: "Wrong input",
        message: "Inches must be a number.",
        preferredStyle: .alert)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func weightInput(_ sender: UITextField) {
        let weight = weightOutlet.text!

        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

        if (Double(weight) == nil) {
        let alert = UIAlertController(title: "Wrong input",
        message: "Weight must be a number.",
        preferredStyle: .alert)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func goalWeightInput(_ sender: UITextField) {
        let goalWeight = goalWeightOutlet.text!

        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

        if (Double(goalWeight) == nil) {
        let alert = UIAlertController(title: "Wrong input",
        message: "Goal weight must be a number.",
        preferredStyle: .alert)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func backgroundTouched(_ sender: UIControl) {
        for txtField in textFields {
            txtField.resignFirstResponder()
        }
    }
    
    @IBAction func calculateBmi(_ sender: UIButton) {
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        if (weightOutlet.text == "" || feetOutlet.text == "" || inchesOutlet.text == "") {
            let alert = UIAlertController(title: "Warning",
            message: "Must enter height and weight.",
            preferredStyle: .alert)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        } else {
            var result: Double = Double(bmiResult.text!)!
            let weight: Double = Double(weightOutlet.text!)!
            let feet:   Double = Double(feetOutlet.text!)!
            var height: Double = Double(inchesOutlet.text!)!
            
            // Formula for feet to inches.
            height = (feet * 12) + height
            
            // BMI formula
            result = 703 * (weight / (height * height))
            bmiResult.text! = String(format: "%.1f", result)
        }
        
        let bmi = Double(bmiResult.text!)!
        self.displayBmiCategory(bmi)
        
    }
    
    // This is to display bmi category the value are given by the American Cancer Society
    func displayBmiCategory(_ bmi : Double) {
        if (bmi == 0) {
             bmiCategoryOutlet.text = "BMI category"
         } else if (bmi <= 18.5 ) {
             bmiCategoryOutlet.text = "UNDERWEIGHT"
             bmiCategoryOutlet.textColor = UIColor.red
         } else if (bmi >= 18.5 && bmi <= 24.9) {
             bmiCategoryOutlet.text = "NORMALWEIGHT"
             bmiCategoryOutlet.textColor = UIColor.blue
         } else if (bmi >= 25 && bmi <= 29.9) {
             bmiCategoryOutlet.text = "OVERWEIGHT"
             bmiCategoryOutlet.textColor = UIColor.red
         } else if (bmi >= 30) {
             bmiCategoryOutlet.text = "OBESE"
             bmiCategoryOutlet.textColor = UIColor.red
         }
    }
    
    // Saving and sending data back to main page
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if let home = presentingViewController?.children[0] as? HomeViewController  {
            
            if let user = user {
                user.name = nameOutlet.text!
                
                if  genderOutlet.selectedSegmentIndex == 0 {
                    user.gender = .male
                } else {
                    user.gender = .female
                }
                
                user.heightInches = Int(inchesOutlet.text!)!
                user.heightFeet = Int(feetOutlet.text!)!
                user.weight = Int(weightOutlet.text!)!
                
                let indexAge = agePickerOutlet.selectedRow(inComponent: 0)
                user.age = Int(ages[indexAge])!
                user.goalWeight = Int(goalWeightOutlet.text!)!
                user.bmi = Double(bmiResult.text!)!
                home.user = user

            }

        }
        dismiss(animated: true, completion: nil)
        
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
