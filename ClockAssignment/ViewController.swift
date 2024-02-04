//
//  ViewController.swift
//  ClockAssignment
//
//  Created by Baik on 2/3/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var timerPicker: UIDatePicker!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var timerDuration: UILabel!
    
    var timeRemaining: Double = 0;
    var timer = Timer()
    
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
    
    @IBAction func startTimer(_ sender: UIButton) {
        
        timeRemaining = timerPicker.countDownDuration
        timerButton.setTitle("Stop Music", for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
        
    }
    
    @objc func step() {
        
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            timer.invalidate()
            timeRemaining = 0;
        }
        
        let timerFormatter = DateComponentsFormatter()
        timerFormatter.allowedUnits = [.hour, .minute, .second]
        let currentDuration = timerFormatter.string(from: timeRemaining)
        
        timerDuration.text = currentDuration
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTime()
    }


}

