//
//  TrackHeaderView.swift
//  Mkuraish-Fitness Tracker
//
//  Created by Aatif Ullah on 3/14/21.
//

import UIKit

class TrackHeaderView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        if let context = UIGraphicsGetCurrentContext() {
             context.setStrokeColor(UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor)
             context.setLineWidth(100)
             context.move(to: CGPoint(x: 0, y: self.frame.size.height ))
             context.addCurve(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height / 2),
                              control1: CGPoint(x: self.frame.size.width / 0.8, y: self.frame.size.height - 50),
                              control2: CGPoint(x: self.frame.size.width / 0.6, y: 150))
             context.setFillColor(UIColor.white.cgColor)
             context.strokePath()
         
         }
    }

}
