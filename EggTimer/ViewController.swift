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
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var cookingProgress: UIProgressView!
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    var timer = Timer()
    
    var player: AVAudioPlayer?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        topLabel.text = "Cooking \(sender.currentTitle!)"
        
        guard var secondsLeft = eggTimes[sender.currentTitle ?? "Soft"] else { return }
        let totalSeconds = secondsLeft
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if secondsLeft > 0 {
                self.cookingProgress.progress = Float(secondsLeft) / Float(totalSeconds)
                secondsLeft -= 1
            } else {
                self.timer.invalidate()
                self.cookingProgress.progress = 0
                self.topLabel.text = "Done!"
                
                guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
                self.player = try? AVAudioPlayer(contentsOf: url)
                self.player?.play()
            }
        }
    }
}
