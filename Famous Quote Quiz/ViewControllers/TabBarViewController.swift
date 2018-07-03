//
//  TabBarViewController.swift
//  Famous Quote Quiz
//
//  Created by Dobromir Penev on 25.06.18.
//  Copyright © 2018 Dobromir Penev. All rights reserved.
//

import UIKit
import FirebaseAuth

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    override func viewDidAppear(_ animated: Bool) {
        
        if Auth.auth().currentUser == nil {
            performSegue(withIdentifier: Identificators.goToLoginId, sender: self)
        }
    }

}
