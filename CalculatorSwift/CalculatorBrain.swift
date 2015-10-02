//
//  CalculatorBrain.swift
//  CalculatorSwift
//
//  Created by Mitchell Fenton on 10/1/15.
//  Copyright © 2015 saymtf. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double->Double)
        case BinaryOperation(String, (Double, Double)->Double)
        
    }
    
    private var opStack = [Op]() // IS THE SAME AS var opStack: Array<Op> = []
    
    private var knownOps = [String:Op]() //var knownOps = Dictionary<String, Op>()
    
    init() {
        knownOps["*"] = Op.BinaryOperation("*", *);
        knownOps["/"] = Op.BinaryOperation("/") { $1 - $0 };
        knownOps["+"] = Op.BinaryOperation("+", +);
        knownOps["-"] = Op.BinaryOperation("-") { $1 - $0 };
        knownOps["-"] = Op.UnaryOperation("√", sqrt);
        
        
    }
    
    func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
        }
        return (nil, ops);
    }
    
    func evaluate() -> Double? {
        
    }
    
    func pushOperand(operand:Double) {
        opStack.append(Op.Operand(operand));
    }
    
    func performOperation(symbol:String) {
        if let operation = knownOps[symbol] {
            opStack.append(operation);
        }
    }
}