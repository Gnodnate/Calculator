//
//  ViewController.swift
//  Calculator
//
//  Created by Dong Tan on 4/5/15.
//  Copyright (c) 2015 Dong Tan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    var userPushTheDotButton: Bool = false
    
    var brain = CalculatorBrain()

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if digit == "." {
            if userPushTheDotButton {
                return
            }
            userPushTheDotButton = true
        }

        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }

    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if operation == "C" {
                brain.clear()
                displayValue = 0
            } else {
                if let result = brain.performOperation(operation) {
                    displayValue = result
                } else {
                    displayValue = 0
                }
            }
        }
        

    }
        
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        userPushTheDotButton  = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue;
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

