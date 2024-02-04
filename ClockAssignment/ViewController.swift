//
//  ViewController.swift
//  ClockAssignment
//
//  Created by Baik on 2/3/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var timerPicker: UIDatePicker!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var timerDuration: UILabel!
    
    var timeRemaining: Double = 0;
    var countdownTimer = Timer()
    var timerOn: Bool = false
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTime()
    }
    
    //shows current datetime in format "Sat, 02 February 2024, 05:03:00 PM"
    func startTime() {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss a"
            let currentTime = dateFormatter.string(from: date)
            self.dateTimeLabel.text = currentTime
        }
    }
    
    @IBAction func timerPressed(_ sender: UIButton) {
        
        if(timerOn == false) {
            startTimer()
        } else{
            stopTimer()
        }
    }
    
    func startTimer() {
        
        timerOn = true
        timeRemaining = timerPicker.countDownDuration
        timerButton.setTitle("Stop Timer", for: .normal)
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
    }
    
    @objc func step() {
        
        if timeRemaining > 0 {
            timeRemaining -= 20
        } else {
            countdownTimer.invalidate()
            timeRemaining = 0
            timerButton.setTitle("Stop Music", for: .normal)
            playMusic()
        }
        
        let timerFormatter = DateComponentsFormatter()
        timerFormatter.allowedUnits = [.hour, .minute, .second]
        let currentDuration = timerFormatter.string(from: timeRemaining)
        
        timerDuration.text = currentDuration
    }
    
    func stopTimer() {
        
        timerOn = false
        countdownTimer.invalidate()
        player?.stop()
        timerButton.setTitle("Start Timer", for: .normal)
    }
    
    func playMusic() {
        
      guard let path = Bundle.main.path(forResource: "soundbite", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }


}

