//
//  SettingsTabBarController.swift
//  Famous Quote Quiz
//
//  Created by Dobromir Penev on 25.06.18.
//  Copyright © 2018 Dobromir Penev. All rights reserved.
//

import UIKit

class SettingsTabBarController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     post notification if user change the mode
     */
    @IBAction func modeChanged(_ sender: UISwitch) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: Identificators.notificationChangeMode), object: nil)
    }

}
