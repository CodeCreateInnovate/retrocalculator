//
//  ViewController.swift
//  retroCalc
//
//  Created by ERICK TRUONG on 12/21/15.
//  Copyright © 2015 Code Create Innovate. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLBL: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLBL.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        ProcessOperation(Operation.Divide)
    }
    
    @IBAction func onMultPressed(sender: AnyObject) {
        ProcessOperation(Operation.Multiply)
    }
    
    @IBAction func onSubractPressed(sender: AnyObject) {
        ProcessOperation(Operation.Subtract)
    }

    @IBAction func onAddPressed(sender: AnyObject) {
        ProcessOperation(Operation.Add)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        ProcessOperation(currentOperation)
    }
    
    func ProcessOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            // Do Some Math
            
            // A User Selected an Operator, but then selected another operator without first entering a number.
            if runningNumber !=  "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLBL.text = result
            }
            
            currentOperation = op
            
            
        } else {
            // This is the first time an operator has been pressed.
            
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
}

