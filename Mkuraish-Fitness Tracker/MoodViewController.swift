//
//  MoodViewController.swift
//  Mkuraish-Fitness Tracker
//
//  Created by Aatif Ullah on 3/8/21.
//

import UIKit

class MoodViewController: UIViewController {
    @IBOutlet weak var burger: UIButton!
    @IBOutlet weak var chowmein: UIButton!
    @IBOutlet weak var hotdog: UIButton!
    @IBOutlet weak var pizza: UIButton!
    @IBOutlet weak var samosa: UIButton!
    @IBOutlet weak var sandwich: UIButton!
    @IBOutlet weak var moodDisplay: UILabel!
    @IBOutlet weak var oval: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.burger.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGestureHandler(panGesture:))))
        
        self.chowmein.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGestureHandler(panGesture2:))))
        
        self.hotdog.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGestureHandler(panGesture3:))))
        
        self.pizza.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGestureHandler(panGesture4:))))
        
        self.samosa.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGestureHandler(panGesture5:))))
        
        self.sandwich.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.panGestureHandler(panGesture6:))))

        // Do any additional setup after loading the view.
    }
    
    @IBAction func burgerButton(_ sender: UIButton) {
        moodDisplay.text = "BURGER!"
        moodDisplay.textColor = UIColor.systemBlue
    }
    
    @objc func panGestureHandler(panGesture moveButton: UIPanGestureRecognizer) {

        let location = moveButton.location(in: view)
        burger.center = location

    }
    
    @IBAction func chowmeinButton(_ sender: UIButton) {
        moodDisplay.text = "CHOWMEIN!"
        moodDisplay.textColor = UIColor.systemBlue
    }
    
    @objc func panGestureHandler(panGesture2 moveButton: UIPanGestureRecognizer) {

        let location = moveButton.location(in: view)
        chowmein.center = location

    }
    
    @IBAction func hotdogButton(_ sender: UIButton) {
        moodDisplay.text = "HOT DOG!"
        moodDisplay.textColor = UIColor.systemBlue
    }
    
    @objc func panGestureHandler(panGesture3 moveButton: UIPanGestureRecognizer) {

        let location = moveButton.location(in: view)
        hotdog.center = location

    }
    
    @IBAction func pizzaButton(_ sender: UIButton) {
        moodDisplay.text = "PIZZA!"
        moodDisplay.textColor = UIColor.systemBlue
    }
    
    @objc func panGestureHandler(panGesture4 moveButton: UIPanGestureRecognizer) {

        let location = moveButton.location(in: view)
        pizza.center = location

    }
    
    @IBAction func samosaButton(_ sender: UIButton) {
        moodDisplay.text = "SAMOSA!"
        moodDisplay.textColor = UIColor.systemBlue
    }
    
    @objc func panGestureHandler(panGesture5 moveButton: UIPanGestureRecognizer) {

        let location = moveButton.location(in: view)
        samosa.center = location

    }
    
    @IBAction func sandwichButton(_ sender: UIButton) {
        moodDisplay.text = "SANDWICH!"
        moodDisplay.textColor = UIColor.systemBlue
    }
    
    @objc func panGestureHandler(panGesture6 moveButton: UIPanGestureRecognizer) {

        let location = moveButton.location(in: view)
        sandwich.center = location

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
