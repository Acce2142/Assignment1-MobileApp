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
            var accTemp :Double;
            lengthTemp = Double(leverLength.text!)!;
            massTemp = Double(mass.text!)!;
            accTemp = Double(accleration.text!)!;
            lengthTemp =  lengthTemp * 0.305;
            massTemp = massTemp * 0.454;
            accTemp =  accTemp * 0.304;
            leverLength.text = String(accTemp.rounded());
            mass.text = String(massTemp.rounded());
            accleration.text = String(accTemp.rounded());
            lengthUnit.text = "Meter";
            massUnit.text = "kg";
            accUnit.text = "m/s";
        } else if(measurementSwitch.selectedSegmentIndex == 1){
            var lengthTemp : Double;
            var massTemp : Double;
            var accTemp :Double;
            lengthTemp = Double(leverLength.text!)!;
            massTemp = Double(mass.text!)!;
            accTemp = Double(accleration.text!)!;
            lengthTemp = lengthTemp * 3.28084;
            massTemp = massTemp * 2.205;
            accTemp = accTemp / 0.327;
            leverLength.text = String(accTemp.rounded());
            mass.text = String(massTemp.rounded());
            accleration.text = String(accTemp.rounded());
            lengthUnit.text = "Feet";
            massUnit.text = "Pound";
            accUnit.text = "ft/s";
        }

    }
    
    @IBAction func scaleSwitch(_ sender: Any) {
        //takes mm and m/s, convert to meter and m/s
        if(measurementSwitch.selectedSegmentIndex == 0 && unitSwitch.selectedSegmentIndex == 0){
            var lengthTemp : Double;
            var accTemp :Double;
            lengthTemp = Double(leverLength.text!)!;
            accTemp = Double(accleration.text!)!;
            lengthTemp = lengthTemp * 1000;
            accTemp = accTemp * 1000;
            leverLength.text = String(accTemp.rounded());
            accleration.text = String(accTemp.rounded());
            lengthUnit.text = "Meter";
            accUnit.text = "m/s";
            //takes meters and m/s. converse to mm and mm/s
        } else if(measurementSwitch.selectedSegmentIndex == 0 && unitSwitch.selectedSegmentIndex == 1){
            var lengthTemp : Double;
            var accTemp :Double;
            lengthTemp = Double(leverLength.text!)!;
            accTemp = Double(accleration.text!)!;
            lengthTemp = lengthTemp / 1000;
            accTemp = accTemp / 1000;
            leverLength.text = String(accTemp.rounded());
            accleration.text = String(accTemp.rounded());
            lengthUnit.text = "Millimeters";
            accUnit.text = "mm/s";
            //takes inch, and inch/s. convert to feet, ft/s
        } else if (measurementSwitch.selectedSegmentIndex == 1 && unitSwitch.selectedSegmentIndex == 0) {
            var lengthTemp : Double;
            var accTemp :Double;
            lengthTemp = Double(leverLength.text!)!;
            accTemp = Double(accleration.text!)!;
            lengthTemp = lengthTemp / 1000;
            accTemp = accTemp / 1000;
            leverLength.text = String(accTemp.rounded());
            accleration.text = String(accTemp.rounded());
            lengthUnit.text = "Feet";
            accUnit.text = "ft/s";
            //takes feet, ft/s, convert to inch, inch/s
        } else if (measurementSwitch.selectedSegmentIndex == 1 && unitSwitch.selectedSegmentIndex == 1){
            var lengthTemp : Double;
            var accTemp :Double;
            lengthTemp = Double(leverLength.text!)!;
            accTemp = Double(accleration.text!)!;
            lengthTemp = lengthTemp / 1000;
            accTemp = accTemp / 1000;
            leverLength.text = String(accTemp.rounded());
            accleration.text = String(accTemp.rounded());
            lengthUnit.text = "Feet";
            accUnit.text = "ft/s";
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
        if(measurementSwitch.selectedSegmentIndex == 0){
            let radius:Double;
            radius = Double(angle.text!)!*M_PI/180;
            let force = Double(mass.text!)! * Double(accleration.text!)!
            let torque = (Double(leverLength.text!)! * force) * sin(radius)
            displayArea.text = "Lever length: \(leverLength.text!)m\nMass: \(mass.text!)kg\nAngle: \(angle.text!)°\nAcceleration: \(accleration.text!)m/s\nTorque: \(torque)N"
        }else{
            let radius:Double;
            radius = Double(angle.text!)!*M_PI/180;
            let force = Double(mass.text!)! * Double(accleration.text!)!
            let torque = (Double(leverLength.text!)! * force) * sin(radius)
            displayArea.text = "Lever length: \(leverLength.text!)ft\nMass: \(mass.text!)pound\nAngle: \(angle.text!)°\nAcceleration: \(accleration.text!)ft/s\nTorque: \(torque)N"
        }
        
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
