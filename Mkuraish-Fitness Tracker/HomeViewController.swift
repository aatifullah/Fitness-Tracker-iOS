//
//  HomeViewController.swift
//  Mkuraish-Fitness Tracker
//
//  Created by Aatif Ullah on 3/8/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    var user = defaultUser
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var genderOutlet: UILabel!
    @IBOutlet weak var ageOutlet: UILabel!
    @IBOutlet weak var heightOutlet: UILabel!
    @IBOutlet weak var weightOutlet: UILabel!
    @IBOutlet weak var bmiOutlet: UILabel!
    @IBOutlet weak var goalWeightOutlet: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dateLabel.text = "Today is \(DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none))"
        
        displayUserInfo(userInfo: user)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // This is to display the user info on home page
    func displayUserInfo(userInfo: User) {
        nameOutlet.text = userInfo.name
        genderOutlet.text = userInfo.gender.rawValue
        ageOutlet.text = String(userInfo.age)
        heightOutlet.text = "\(String(userInfo.heightFeet))' \(String(userInfo.heightInches))"
        bmiOutlet.text = String(userInfo.bmi)
        goalWeightOutlet.text = String(userInfo.goalWeight)
        
    }
    
    // send to settingsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settings = segue.destination as? SettingsViewController {
            settings.user = user
        }
    }
    
    // receive data from settings and display updated data
    override func viewWillAppear(_ animated: Bool) {
        nameOutlet.text = user.name
        genderOutlet.text = user.gender.rawValue
        ageOutlet.text = String(user.age)
        heightOutlet.text = "\(String(user.heightFeet))\' \(String(user.heightInches))\""
        weightOutlet.text = String(user.weight)
        bmiOutlet.text = String(user.bmi)
        goalWeightOutlet.text = String(user.goalWeight)
    }

}
