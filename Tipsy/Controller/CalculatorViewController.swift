//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        guard let buttonTitle = sender.currentTitle else { return }
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        guard let buttonTitleAsAnswer = Double(buttonTitleMinusPercentSign) else { return }
        tip = buttonTitleAsAnswer / 100
        billTextField.endEditing(true)
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        guard let bill = billTextField.text, !bill.isEmpty else { return }
        guard let billTotal = Double(bill) else { return }
        let result = billTotal * (1.0 + tip) / Double(numberOfPeople)
        finalResult = String(format: "%.2f", result)
        
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToResults", let destinationVC = segue.destination as? ResultsViewController else { return }
        destinationVC.result = finalResult
        destinationVC.tip = Int(tip * 100)
        destinationVC.split = numberOfPeople
        
    }
}

