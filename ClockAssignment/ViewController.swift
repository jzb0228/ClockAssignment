//
//  ViewController.swift
//  ClockAssignment
//
//  Created by Justin Baik on 2/3/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var timerPicker: UIDatePicker!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var timerDuration: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var timeRemaining: Double = 0;
    var countdownTimer = Timer()
    var player: AVAudioPlayer?
    var isPlaying: Bool = false
    var timerOn: Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        startTime()
        changeBackgroundImage()
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
    
    @IBAction func buttonPressed(_ sender: UIButton) {

        if(isPlaying == false) {
            
            if(timerOn == false) {
                startTimer()
                timerPicker.isEnabled = false
            } else{
                resetTimer()
                timerPicker.isEnabled = true
            }
            
        } else{
            stopMusic()
            timerPicker.isEnabled = true
        }
        
    func startTimer() {
        
        timerOn = true
        timerButton.setTitle("Reset Timer", for: .normal)
        timerPicker.isEnabled = false
        timeRemaining = timerPicker.countDownDuration
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
        }
    }
    
    @objc func step() {
        
        if timeRemaining > 0 {
            timeRemaining -= 1
            let formattedTimeRemaining = timerFormatter.string(from: timeRemaining)
            timerDuration.text = "Time Remaining: \(formattedTimeRemaining ?? "0")"
        } else{
            countdownTimer.invalidate()
            playMusic()
        }
    }
    
    func resetTimer() {
        
        timerOn = false
        timerButton.setTitle("Start Timer", for: .normal)
        timerDuration.text = "Time Remaining: 00:00:00"
        countdownTimer.invalidate()
    }
    
    func playMusic() {
        
      isPlaying = true
      timerDuration.text = "Now Playing"
      timerButton.setTitle("Stop Music", for: .normal)
 
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
    
    func stopMusic() {
        
        isPlaying = false
        timerDuration.text = "Time Remaining: 00:00:00"
        timerButton.setTitle("Start Timer", for: .normal)
        player?.stop()
        countdownTimer.invalidate()
    }

    func changeBackgroundImage() {
        
        let hour = Calendar.current.component(.hour, from: Date())
        if(hour < 12) {
            backgroundImage.image = UIImage(named: "amImage")
        } else{backgroundImage.image = UIImage(named: "pmImage")}
    }
    
    var timerFormatter : DateComponentsFormatter {
        
        let myFormatter = DateComponentsFormatter()
        myFormatter.allowedUnits = [.hour, .minute, .second]
        myFormatter.zeroFormattingBehavior = .pad
        return myFormatter
    }
}

