//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Rossi, Matthew Th on 1/23/19.
//  Copyright © 2019 Rossi, Matthew. All rights reserved.
//

/*
 I worked on this by myself.
 I finished all of the challenges, though I'm not sure how to prove to you that I removed all the constraints and redid them.
 
 But the other 2 are done.
 
 - Matt Rossi
 
 */

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    @IBOutlet var Background: UIView!
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField){
        
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view")
        updateCelsiusLabel()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel(){
        if let celsiusValue = celsiusValue {
          celsiusLabel.text =
            numberFormatter.string(from: NSNumber(value: celsiusValue.value))
            
        } else {
          celsiusLabel.text = "???"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existingTextHasDecimalSeperator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        //If our string has letters in it..
        let hasLetters = string.rangeOfCharacter(from: NSCharacterSet.letters)
        
        //return false!
        if existingTextHasDecimalSeperator != nil &&
            replacementTextHasDecimalSeparator != nil ||
            hasLetters != nil {
            return false
        } else {
            return true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Change View background color each time it is viewed
        let colorsArray: [UIColor] = [.blue, .green, .white, .black, .orange, .red]
        let randomInt = Int.random(in: 0...5)
        Background.backgroundColor = colorsArray[randomInt]
        }
    
}
