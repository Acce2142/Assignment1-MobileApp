//
//  ViewController.swift
//  Assignment2
//
//  Created by ZHENG, Duoqi - zhedy005 on 26/8/18.
//  Copyright © 2018 ZHENG, Duoqi - zhedy005. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leverLength: UITextField!
    @IBOutlet weak var mass: UITextField!
    @IBOutlet weak var angle: UITextField!
    @IBOutlet weak var accleration: UITextField!
    @IBOutlet weak var unitSwitch: UISegmentedControl!
    @IBOutlet weak var measurementSwitch: UISegmentedControl!
    @IBOutlet weak var torqueReverseEngineer: UITextField!
    @IBOutlet weak var massReverseEngineer: UITextField!
    @IBOutlet weak var displayArea: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        leverLength.delegate? = self;
        mass.delegate? = self;
        angle.delegate? = self;
        accleration.delegate? = self;
        torqueReverseEngineer.delegate? = self;
        massReverseEngineer.delegate? = self;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        leverLength.resignFirstResponder();
        mass.resignFirstResponder();
        angle.resignFirstResponder();
        accleration.resignFirstResponder();
        torqueReverseEngineer.resignFirstResponder();
        massReverseEngineer.resignFirstResponder();
        
    }

    
    @IBAction func calculateTorque(_ sender: Any) {
        let radius:Double;
        radius = Double(angle.text!)!*M_PI/180;
        let force = Double(mass.text!)! * Double(accleration.text!)!
        let torque = (Double(leverLength.text!)! * force) * sin(radius)
        displayArea.text = "Lever length: \(leverLength.text!)m\nMass: \(mass.text!)kg\nAngle: \(angle.text!)°\nAcceleration: \(accleration.text!)m/s\nTorque: \(torque)N"
    }
    
    @IBAction func reverseEngineer(_ sender: Any) {
        let forceProduce:Double;
        let radius:Double;
        let accele:Double;
        radius = Double(angle.text!)!*M_PI/180;
        forceProduce = Double(torqueReverseEngineer.text!)! / (Double(leverLength.text!)!*sin(radius))
        accele = forceProduce / Double(massReverseEngineer.text!)!;
        displayArea.text = "Given Torque:  \(torqueReverseEngineer.text)N\nLever length: \(leverLength.text)m\nAngle: \(angle.text)°\nMass: \(massReverseEngineer.text)kg\nForce produce:\(forceProduce)N\nExpected Acceleration: \(accele)m/s"
    }
    
}
extension ViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
}
