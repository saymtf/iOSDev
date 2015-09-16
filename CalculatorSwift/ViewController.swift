//
//  ViewController.swift
//  CalculatorSwift
//
//  Created by Mitchell Fenton on 9/1/15.
//  Copyright (c) 2015 saymtf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false;
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!; // let is a constant, ! gets the string of button
        //println("Digit = \(digit)"); // print
        if( userIsInTheMiddleOfTypingANumber) {
            if((digit == "." && display.text!.rangeOfString(".") != nil)) {
                return;
            }
            display.text = display.text! + digit; // need !, bc its an optional type need to unwrap
        }else {
            display.text = digit;
            userIsInTheMiddleOfTypingANumber = true;
        }
    }
    
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!;
        if(userIsInTheMiddleOfTypingANumber) {
            enter();
        }
        
        switch operation {
        case "X":
            // performs a quick closure function
            performOperation { $0 * $1 };
        case "/":
            // performs a quick closure function
            performOperation { $1 / $0 };
        case "+":
            // performs a quick closure function
            performOperation { $0 + $1 };
        case "-":
            // performs a quick closure function
            performOperation { $1 - $0 };
        case "√":
            // performs a quick closure function
            performOperation { sqrt($0) };
        case "cos":
            // performs a quick closure function
            performOperation { cos($0) };
        case "sin":
            // performs a quick closure function
            performOperation { sin($0) };
        default: break;
        }
    }
    
    // Takes two doubles and returns a double
    func performOperation(operation: (Double, Double) -> Double) {
        if(operandStack.count >= 2) {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast());
            enter();
        }
    }

    // Takes two doubles and returns a double
    func performOperation(operation: (Double) -> Double) {
        if(operandStack.count >= 1) {
            displayValue = operation(operandStack.removeLast());
            enter();
        }
    }
    
    //var operandStack: Array<Double> = Array<Double>();
    var operandStack = Array<Double>(); // infers that it's an Array
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false;
        operandStack.append(displayValue); // call the computed prop.
        println("operandStack = \(operandStack)");
    }
    
    //computed properties
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue;
        }
        set {
            display.text = "\(newValue)"; //converts newValue to string
            userIsInTheMiddleOfTypingANumber = false;
        }
    }
    
    @IBAction func clear() {
        operandStack.removeAll();
        display.text! = "\(0)";
        userIsInTheMiddleOfTypingANumber = false;
    }
}

