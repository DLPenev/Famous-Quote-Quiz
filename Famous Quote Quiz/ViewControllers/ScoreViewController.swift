//
//  ScoreViewController.swift
//  Famous Quote Quiz
//
//  Created by Dobromir Penev on 26.06.18.
//  Copyright © 2018 Dobromir Penev. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var wellDoneLabel: UILabel!
    
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wellDoneLabel.isHidden = true
        scoreLabel.text = "\(score) out of 10"
        
        if score == 10 {
            wellDoneLabel.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     post notification if user press restart button
     */
    @IBAction func restartPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: Identificators.notificationRestart), object: nil)
        dismiss(animated: true)
    }
    

}
