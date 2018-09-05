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
        massReverseEngineer.delegate? = self;
        // Do any additional setup after loading the view, typically from a nib.
    }
    //Metric && Imperial measurement switch
    @IBAction func metricSwitch(_ sender: Any) {
        var lengthTemp : Double;
        var massTemp : Double;
        if (leverLength.text != "" && mass.text != "")
        {
            lengthTemp = Double(leverLength.text!)!;
            massTemp = Double(mass.text!)!;
            if(measurementSwitch.selectedSegmentIndex == 0){
                massTemp = massTemp * 0.453592;
                mass.text = String(round(massTemp*100)/100);
                massUnit.text = "kg";
                if(unitSwitch.selectedSegmentIndex == 0){
                    lengthTemp =  lengthTemp * 0.305;
                    leverLength.text = String(round(lengthTemp*100)/100);
                    lengthUnit.text = "Meters";
                } else if(unitSwitch.selectedSegmentIndex == 1){
                    //inches to Millimeters
                    lengthTemp = lengthTemp / 12; //feet
                    lengthTemp = lengthTemp * 0.305; //meters
                    lengthTemp = lengthTemp * 1000; // mm,
                    leverLength.text = String(round(lengthTemp*100)/100);
                    lengthUnit.text = "Millimeters";
                }
            } else if(measurementSwitch.selectedSegmentIndex == 1){
                massTemp = massTemp * 2.20462;
                mass.text = String(round(massTemp*100)/100);
                massUnit.text = "Pound";
                if(unitSwitch.selectedSegmentIndex == 0){
                    lengthTemp = lengthTemp * 3.28084;
                    leverLength.text = String(round(lengthTemp*100)/100);
                    lengthUnit.text = "Feet";
                } else if(unitSwitch.selectedSegmentIndex == 1){
                    //Millimeters to inches
                    lengthTemp = lengthTemp / 1000; //mm to meters
                    lengthTemp = lengthTemp * 3.28084; // meters to feet
                    lengthTemp = lengthTemp * 12; //feet to inches
                    leverLength.text = String(round(lengthTemp*100)/100);
                    lengthUnit.text = "Inches";
                }
            }

        } else {
            //if user does something wrong, reset to meter/metric
            measurementSwitch.selectedSegmentIndex = 0;
            massUnit.text = "kg";
            lengthUnit.text = "Meters";
            unitSwitch.selectedSegmentIndex = 0;
            leverLength.text = "0";
            mass.text = "0";
            let alertController = UIAlertController(title: "Invalid value", message: "All the inputs must be numeric/not-empty", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    //convert meters to Millimeters or feet to inches
    @IBAction func scaleSwitch(_ sender: Any) {
        //mm to meters
        var lengthTemp : Double;
        if (leverLength.text != "" && mass.text != ""){
            lengthTemp = Double(leverLength.text!)!;
            if(measurementSwitch.selectedSegmentIndex == 0 && unitSwitch.selectedSegmentIndex == 0){
                lengthTemp = lengthTemp / 1000;
                lengthUnit.text = "Meter";
                leverLength.text = String(round(lengthTemp*100)/100);
                //meter to mm
            } else if(measurementSwitch.selectedSegmentIndex == 0 && unitSwitch.selectedSegmentIndex == 1){
                lengthTemp = lengthTemp * 1000;
                lengthUnit.text = "Millimeters";
                leverLength.text = String(round(lengthTemp*100)/100);
                //feet to inches
            } else if(measurementSwitch.selectedSegmentIndex == 1 && unitSwitch.selectedSegmentIndex == 1){
                lengthTemp = lengthTemp * 12;
                lengthUnit.text = "Inches";
                leverLength.text = String(round(lengthTemp*100)/100);
                //inches to feet
            } else if(measurementSwitch.selectedSegmentIndex == 1){
                if(unitSwitch.selectedSegmentIndex == 0){
                    lengthTemp = lengthTemp / 12 ;
                    lengthUnit.text = "Feet";
                    leverLength.text = String(round(lengthTemp*100)/100);
                }
            }

        } else {
            measurementSwitch.selectedSegmentIndex = 0;
            unitSwitch.selectedSegmentIndex = 0;
            massUnit.text = "kg";
            lengthUnit.text = "Meter";
            leverLength.text = "0";
            mass.text = "0";
            let alertController = UIAlertController(title: "Invalid value", message: "All the inputs must be numeric/not-empty", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
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

    // calculate the torque
    @IBAction func calculateTorque(_ sender: Any) {
        let radius:Double;
        var lengthTemp : Double;
        var massTemp : Double;
        let acc : Double;
        //check the empty strings
        if (accleration.text != "" && mass.text != "" && leverLength.text != "" && angle.text != "")
        {
            //check whether the input is numeric
            if(isNumeric(string: accleration.text!) == true && isNumeric(string:mass.text!) == true && isNumeric(string:leverLength.text!) == true && isNumeric(string:angle.text!) == true)
            {
                acc = Double(accleration.text!)!
                massTemp = Double(mass.text!)!
                lengthTemp = Double(leverLength.text!)!
                radius = Double(angle.text!)!*M_PI/180;
                if(radius > 1.5708){
                    let alertController = UIAlertController(title: "Invalid degree", message: "You should only input degree in the range of 0-90 degress. If you input degree over that limit, It will still work but might has something weird happens", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
                if(measurementSwitch.selectedSegmentIndex == 0){
                    //mass is in kg
                    if(unitSwitch.selectedSegmentIndex == 0){
                        //length is in meter
                        let force = massTemp * acc
                        let torque = (lengthTemp * force) * sin(radius)
                        displayArea.text = "Lever length: \(leverLength.text!)m\nMass: \(mass.text!)kg\nAngle: \(angle.text!)°\nAcceleration: \(accleration.text!)m/s\nTorque: \(round(torque*100)/100)N"
                    } else {
                        // length is in mm,
                        let force = massTemp * acc
                        lengthTemp = lengthTemp / 1000;
                        let torque = (lengthTemp * force) * sin(radius)
                        displayArea.text = "Lever length: \(leverLength.text!)mm\nMass: \(mass.text!)kg\nAngle: \(angle.text!)°\nAcceleration: \(accleration.text!)m/s\nTorque: \(round(torque*100)/100)N"
                    }
                }else if(measurementSwitch.selectedSegmentIndex == 1){
                    //mass is in pound
                    if(unitSwitch.selectedSegmentIndex == 0){
                        //length is in feet
                        massTemp = massTemp * 0.453592;
                        lengthTemp = lengthTemp * 0.305;
                        let force = massTemp * acc
                        let torque = (lengthTemp * force) * sin(radius)
                        displayArea.text = "Lever length: \(leverLength.text!) ft\nMass: \(mass.text!) pound\nAngle: \(angle.text!)°\nAcceleration: \(accleration.text!) m/s\nTorque: \(round(torque*100)/100) N"
                    } else {
                        //length is in inches
                        massTemp = massTemp * 0.453592;
                        lengthTemp = lengthTemp / 12 * 0.305;
                        let force = massTemp * acc
                        let torque = (lengthTemp * force) * sin(radius)
                        displayArea.text = "Lever length: \(leverLength.text!) inches\nMass: \(mass.text!) pound\nAngle: \(angle.text!)°\nAcceleration: \(accleration.text!) m/s\nTorque: \(round(torque*100)/100) N"
                    }
                }
            } else {
                let alertController = UIAlertController(title: "Invalid value", message: "All the inputs must be numeric/not-empty", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)            }
        } else {
            let alertController = UIAlertController(title: "Invalid value", message: "All the inputs must be numeric/not-empty", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
 }
    //reverse engineer a torque and calculate the force produce. Then calculate the expected acceleration
    @IBAction func reverseEngineer(_ sender: Any) {
        //forceproduce = Torque/ sin() /leverlength
        var forceProduce:Double;
        var radius:Double;
        var accele:Double;
        var lengthTemp : Double;
        var massTemp : Double;
        var torqueTemp : Double;
        
        // temp values, initially in metric
        //input validation
        //check empty string
        if (massReverseEngineer.text != "" && torqueReverseEngineer.text != "" && leverLength.text != "" && angle.text != "" && accleration.text != "" && mass.text != "" && leverLength.text != "")
        {
            //check numeric
            if(isNumeric(string: angle.text!) == true && isNumeric(string:massReverseEngineer.text!) == true && isNumeric(string:torqueReverseEngineer.text!) == true && isNumeric(string:leverLength.text!) == true)
            {
                radius = Double(angle.text!)!*M_PI/180;
                massTemp = Double(massReverseEngineer.text!)!
                torqueTemp = Double(torqueReverseEngineer.text!)!
                lengthTemp = Double(leverLength.text!)!
                //check whether the degree number is in the range of 0-90
                if(radius > 1.5708){
                    let alertController = UIAlertController(title: "Invalid degree", message: "You should only input degree in the range of 0-90 degress. If you input degree over that limit, It will still work but something weird might happens", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
                //f = m * a
                if(measurementSwitch.selectedSegmentIndex == 0){
                    //mass is in kg
                    if(unitSwitch.selectedSegmentIndex == 0){
                        //length is in meter
                        forceProduce = torqueTemp / sin(radius)/(lengthTemp)
                        accele = forceProduce / massTemp;
                        displayArea.text = "Given Torque:  \(torqueTemp)N\nLever length: \(leverLength.text)m\nAngle: \(angle.text)°\nMass: \(massTemp)kg\nForce produce:\(round(forceProduce*100)/100)N\nExpected Acceleration: \(accele)m/s"
                    } else {
                        //length is in mm
                        forceProduce = torqueTemp / sin(radius)/(lengthTemp)
                        accele = forceProduce / massTemp;
                        displayArea.text = "Given Torque:  \(torqueTemp)N\nLever length: \(leverLength.text)mm\nAngle: \(angle.text)°\nMass: \(massTemp)kg\nForce produce:\(round(forceProduce*100)/100)N\nExpected Acceleration: \(accele)m/s"
                    }
                }else if(measurementSwitch.selectedSegmentIndex == 1){
                    //mass is in pound
                    //mass is in pound, so we need to convert it to kgs
                    massTemp = massTemp * 0.453592;
                    if(unitSwitch.selectedSegmentIndex == 0){
                        forceProduce = torqueTemp  / sin(radius)/(lengthTemp)
                        accele = forceProduce / massTemp;
                        displayArea.text = "Given Torque:  \(torqueTemp)N\nLever length: \(leverLength.text)feet\nAngle: \(angle.text)°\nMass: \(massReverseEngineer.text)pound\nForce produce:\(round(forceProduce*100)/100))N\nExpected Acceleration: \(round(accele*100)/100)m/s"
                    } else {
                        forceProduce = torqueTemp / sin(radius)/(lengthTemp)
                        accele = forceProduce / massTemp;
                        displayArea.text = "Given Torque:  \(torqueTemp)N\nLever length: \(leverLength.text)inches\nAngle: \(angle.text)°\nMass: \(massReverseEngineer.text)kg\nForce produce:\(round(forceProduce*100)/100)N\nExpected Acceleration: \(accele)m/s"
                    }
                    
                }

            } else {
                let alertController = UIAlertController(title: "Invalid value", message: "All the inputs must be numeric/not-empty", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            
            } else {
            let alertController = UIAlertController(title: "Invalid value", message: "All the inputs must be numeric/not-empty", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
}
//check whether the string contains letters
//if it contains letters return false
//else return true
func isNumeric(string: String) -> Bool{
    if(string.rangeOfCharacter(from: NSCharacterSet.letters) != nil || string.rangeOfCharacter(from: NSCharacterSet.whitespaces) != nil){
        return false;
    } else {
        return true;
    }
}
extension ViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
}
