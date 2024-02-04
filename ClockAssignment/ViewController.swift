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
    //var timerOn: Bool = false
    var player: AVAudioPlayer?
    var isPlaying: Bool = false
    
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
    
//    @IBAction func buttonPressed(_ sender: UIButton) {
//
//        if(timerOn == false) {
//            startTimer()
//        } else{
//            stopTimer()
//        }
//    }
    
    @IBAction func startTimer() {
        
        if(isPlaying == false){
            //timerOn = true
            timerButton.isEnabled = false
            timerPicker.isEnabled = false
            timeRemaining = timerPicker.countDownDuration
            //timerButton.setTitle("Stop Timer", for: .normal)
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
        }else {
            timerButton.setTitle("Start Timer", for: .normal)
            timerDuration.text = "Time Remaining: 00:00:00"
            timerPicker.isEnabled = true
            isPlaying = false
            player?.stop()
        }
    }
    
    @objc func step() {
        
        if timeRemaining > 0 {
            timeRemaining -= 1
            timerDuration.text = "Time Remaining: \(timeRemaining)"
        } else {
            countdownTimer.invalidate()
            timeRemaining = 0
            //timerButton.setTitle("Stop Music", for: .normal)
            playMusic()
            timerButton.setTitle("Stop Music", for: .normal)
        }
        
//        let timerFormatter = DateComponentsFormatter()
//        timerFormatter.allowedUnits = [.hour, .minute, .second]
//        let currentDuration = timerFormatter.string(from: timeRemaining)
    }
    
//    func stopTimer() {
//        
//        timerOn = false
//        countdownTimer.invalidate()
//        player?.stop()
//        timerButton.setTitle("Start Timer", for: .normal)
//    }
    
    func playMusic() {
      
      isPlaying = true
      timerDuration.text = "Now Playing"
      timerButton.isEnabled = true
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

    func changeBackgroundImage() {
        
        let hour = Calendar.current.component(.hour, from: Date())
        if(hour < 12) {
            backgroundImage.image = UIImage(named: "amImage")
        }else { backgroundImage.image = UIImage(named: "pmImage")}
    }

}

