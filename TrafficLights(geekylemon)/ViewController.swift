//
//  ViewController.swift
//  TrafficLights(geekylemon)
//
//  Created by Colin Mackenzie on 29/03/2016.
//  Copyright © 2016 nilocski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView:    UIImageView!
    @IBOutlet var label:        UILabel!
    @IBOutlet var buttonOutlet: UIButton!
    
    var timerCountDown = NSTimer()
    var timerScore     = NSTimer()
    
    var secondsCountDownToStart = 0
    
    // High score is good. Max score is 1000.
    var score = 0
    
    enum GameState: Int {
        case NotRunning
        case CountingDown
        case Running
    }
    
    var thisGameState: GameState = .NotRunning
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        resetGame("Start")
        label.text = "0"
        
    }

     @IBAction func startStop(sender: UIButton) {
        
        
        switch thisGameState {
        case .Running:
            // Player taps button, stop the game.
            timerScore.invalidate()
            resetGame("Restart")
            
        case .NotRunning:
            // Player taps button, start the game.
            resetGame("Start")
            thisGameState = .CountingDown
            
            // start the 3 second countdown sequence
            secondsCountDownToStart = 3
            timerCountDown = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.countingDownToStart), userInfo: nil, repeats: true)
            
             break
            
        case .CountingDown:
            break

        }
     }
    
    func countingDownToStart() {
        
        secondsCountDownToStart = secondsCountDownToStart - 1
        
        // Countdown is 2 Seconds before start
        if secondsCountDownToStart > 1 {
            imageView.image = UIImage(named: "TrafficLight3")    // RED
        }
        // Countdown is 1 Second before start
        else if secondsCountDownToStart == 1 {
            imageView.image = UIImage(named: "TrafficLight2")    // YELLOW
        }
        // Countdown is 0 Seconds, at start
        
        else {
            
            imageView.image = UIImage(named: "TrafficLight1")   // GREEN
            timerCountDown.invalidate()
            
            timerScore = NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: #selector(ViewController.decreaseScore), userInfo: nil, repeats: true)
            
            buttonOutlet.setTitle("Stop", forState: .Normal)
            
            thisGameState = .Running
         }
     }
    
    func decreaseScore() {
        // decreasing score from 1000 to 0
        score = score - 1
        label.text = String(score)
        if score < 1 {
            // Player has run out of time.
            timerScore.invalidate()
            resetGame("Restart")
        }

    }
    
    
    func resetGame(startrestartLabelText: String) {
        
        score = 1000
        imageView.image = UIImage(named: "TrafficLight")
        buttonOutlet.setTitle(startrestartLabelText, forState: .Normal)
        thisGameState = .NotRunning
    }
    
    
    
}

