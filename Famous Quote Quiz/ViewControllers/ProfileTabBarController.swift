//
//  ProfileTabBarController.swift
//  Famous Quote Quiz
//
//  Created by Dobromir Penev on 25.06.18.
//  Copyright © 2018 Dobromir Penev. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileTabBarController: UIViewController {
    @IBOutlet weak var userEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmailLabel.text = Auth.auth().currentUser?.email
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     create alert to inform user that cannot log out
     */
    func createAlert(){
        let alert = UIAlertController(title: "Error", message: "Sign out error", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func logOutTouchUp() {
        
        do {
            try Auth.auth().signOut()
            let logInController = storyboard?.instantiateViewController(withIdentifier: Identificators.logInControllerId) as! LoginViewController
            present(logInController, animated: true, completion: nil)
            
        } catch {
            createAlert()
        }
        
    }
    
}
