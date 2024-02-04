//
//  ViewController.swift
//  ClockAssignment
//
//  Created by Baik on 2/3/24.
//

import UIKit

class ViewController: UIViewController {

    //Label showing current date
    @IBOutlet weak var dateTimeLabel: UILabel!
    //shows current datetime in format "Sat, 02 February 2024, 05:03:00 PM"
    fileprivate func startTime() {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            let date = Date() + 40000
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss a"
            let currentTime = dateFormatter.string(from: date)
            self.dateTimeLabel.text = currentTime
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTime()
    }


}

