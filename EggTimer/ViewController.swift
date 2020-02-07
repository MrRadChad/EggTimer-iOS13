//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = [
        "Soft": 3,
        "Medium": 4,
        "Hard": 7
    ]
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var player: AVAudioPlayer!
    var countdownTimer: Timer!
    var totalTime = 0
    var timeElapsed = 0
    
    
    func alarmSound(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    func fireTimer(_ : Int){
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        print(timeElapsed)
        if(timeElapsed < totalTime){
            
            timeElapsed += 1
            
            let progressPercentage = Float(timeElapsed) / Float(totalTime)
            
            progressView.progress = progressPercentage
            
        } else {
            endTimer()
            titleLabel.text = "Egg Cooked!"
            alarmSound()
        }
    }
    
    func endTimer(){
        countdownTimer.invalidate()
    }
    
    func setProgress(){
        
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        
        titleLabel.text = hardness
        
        progressView.progress = 0.0
        timeElapsed = 0
        
        totalTime = eggTimes[hardness]!
        
        fireTimer(totalTime)
        
    }

}
