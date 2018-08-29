//
//  ViewController.swift
//  Assignment2
//
//  Created by ZHENG, Duoqi - zhedy005 on 26/8/18.
//  Copyright © 2018 ZHENG, Duoqi - zhedy005. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var unitSwitch: UISegmentedControl!
    @IBOutlet weak var measurementSwitch: UISegmentedControl!
    
    @IBOutlet weak var leverLength: UITextField!
    var leverLengthDelegate : Double!
    @IBOutlet weak var mass: UITextField!
    var massDelegate : Double!
    @IBOutlet weak var angle: UITextField!
    var angleDelegate : Double!
    @IBOutlet weak var accleration: UITextField!
    var accDelegate : Double!
    @IBOutlet weak var torqueReverseEngineer: UITextField!
    var torqueReverseEngineerDelegate : Double!
    @IBOutlet weak var massReverseEngineer: UITextField!
    var massReverseEngineerDelegate : Double!
    
    @IBOutlet weak var displayArea: UITextView!
    @IBOutlet weak var lengthUnit: UILabel!
    @IBOutlet weak var massUnit: UILabel!
    @IBOutlet weak var accUnit: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        leverLength.delegate? = self;
        leverLength.text = "2";
        mass.delegate? = self;
        mass.text = "1000";
        angle.delegate? = self;
        angle.text = "90";
        accleration.delegate? = self;
        accleration.text = "5";
        torqueReverseEngineer.delegate? = self;
        torqueReverseEngineer.text = "10000";
        massReverseEngineer.delegate? = self;
        massReverseEngineer.text = "1000";
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func metricSwitch(_ sender: Any) {
        if(measurementSwitch.selectedSegmentIndex == 0){
            var lengthTemp : Double;
            var massTemp : Double;
            lengthTemp = Double(leverLength.text!)!;
            massTemp = Double(mass.text!)!;
            lengthTemp =  lengthTemp * 0.305;
            massTemp = massTemp * 0.453592;
            leverLength.text = String(round(lengthTemp*100)/100);
            mass.text = String(round(massTemp*100)/100);
            lengthUnit.text = "Meter";
            massUnit.text = "kg";
        } else if(measurementSwitch.selectedSegmentIndex == 1){
            var lengthTemp : Double;
            var massTemp : Double;
            lengthTemp = Double(leverLength.text!)!;
            massTemp = Double(mass.text!)!;
            lengthTemp = lengthTemp * 3.28084;
            massTemp = massTemp * 2.20462;
            leverLength.text = String(round(lengthTemp*100)/100);
            mass.text = String(round(massTemp*100)/100);
            lengthUnit.text = "Feet";
            massUnit.text = "Pound";
        }

    }
    
    @IBAction func scaleSwitch(_ sender: Any) {
        //mm to meters
        if(measurementSwitch.selectedSegmentIndex == 0 && unitSwitch.selectedSegmentIndex == 0){
            var lengthTemp : Double;
            lengthTemp = Double(leverLength.text!)!;
            lengthTemp = lengthTemp / 1000;
            lengthUnit.text = "Meter";
            leverLength.text = String(round(lengthTemp*100)/100);
        //meter to mm
        } else if(measurementSwitch.selectedSegmentIndex == 0 && unitSwitch.selectedSegmentIndex == 1){
            var lengthTemp : Double;
            lengthTemp = Double(leverLength.text!)!;
            lengthTemp = lengthTemp * 1000;
            lengthUnit.text = "Millimeters";
            leverLength.text = String(round(lengthTemp*100)/100);
        }
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
        if(measurementSwitch.selectedSegmentIndex == 0){
            if(unitSwitch.selectedSegmentIndex == 0){
                let force = (Double(mass.text!)!) * Double(accleration.text!)!
                let torque = ((Double(leverLength.text!)!) * force) * sin(radius)
                displayArea.text = "Lever length: \(leverLength.text!)m\nMass: \(mass.text!)kg\nAngle: \(angle.text!)°\nAcceleration: \(accleration.text!)m/s\nTorque: \(round(torque*100)/100)N"
            } else {
                let force = (Double(mass.text!)!) * Double(accleration.text!)!
                let torque = ((Double(leverLength.text!)!/1000) * force) * sin(radius)
                displayArea.text = "Lever length: \(leverLength.text!)mm\nMass: \(mass.text!)kg\nAngle: \(angle.text!)°\nAcceleration: \(accleration.text!)mm/s\nTorque: \(round(torque*100)/100)N"
            }
        }else if(measurementSwitch.selectedSegmentIndex == 1){
            if(unitSwitch.selectedSegmentIndex == 0){
                let force = (Double(mass.text!)!*0.454) * Double(accleration.text!)!
                let torque = ((Double(leverLength.text!)!*0.305) * force) * sin(radius)
                displayArea.text = "Lever length: \(leverLength.text!) ft\nMass: \(mass.text!) pound\nAngle: \(angle.text!)°\nAcceleration: \(accleration.text!) m/s\nTorque: \(round(torque*100)/100) N"
            } else {
                let force = (Double(mass.text!)!*0.454) * Double(accleration.text!)!
                let torque = ((Double(leverLength.text!)!*0.305*12) * force) * sin(radius)
                displayArea.text = "Lever length: \(leverLength.text!) inches\nMass: \(mass.text!) pound\nAngle: \(angle.text!)°\nAcceleration: \(accleration.text!) m/s\nTorque: \(round(torque*100)/100) N"
            }
        }
    }
    
    @IBAction func reverseEngineer(_ sender: Any) {
        var forceProduce:Double;
        var radius:Double;
        var accele:Double;
        if(measurementSwitch.selectedSegmentIndex == 0){
            radius = Double(angle.text!)!*M_PI/180;
            forceProduce = Double(torqueReverseEngineer.text!)! / (Double(leverLength.text!)!*sin(radius))
            accele = forceProduce / Double(massReverseEngineer.text!)!;
            displayArea.text = "Given Torque:  \(torqueReverseEngineer.text)N\nLever length: \(leverLength.text)m\nAngle: \(angle.text)°\nMass: \(massReverseEngineer.text)kg\nForce produce:\(forceProduce)N\nExpected Acceleration: \(accele)m/s"
        }else if(measurementSwitch.selectedSegmentIndex == 1){
            radius = Double(angle.text!)!*M_PI/180;
            forceProduce = Double(torqueReverseEngineer.text!)! / ((Double(leverLength.text!)!*0.305)*sin(radius))
            accele = forceProduce / Double(massReverseEngineer.text!)!*0.454;
            displayArea.text = "Given Torque:  \(torqueReverseEngineer.text)N\nLever length: \(leverLength.text)feet\nAngle: \(angle.text)°\nMass: \(massReverseEngineer.text)pound\nForce produce:\(round(forceProduce*100)/100))N\nExpected Acceleration: \(round(accele*100)/100)m/s"
        }
        
    }
    
}
extension ViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
}
