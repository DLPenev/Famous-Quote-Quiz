//
//  LoginViewController.swift
//  Famous Quote Quiz
//
//  Created by Dobromir Penev on 25.06.18.
//  Copyright © 2018 Dobromir Penev. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - outlets and variables
    
    @IBOutlet weak var loginOrCreateButton: UIButton!
    @IBOutlet weak var createAccOrCancelButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var invalidMailLabel: UILabel!
    @IBOutlet weak var invalidPassLabel: UILabel!

    var isLogin = true

    // MARK: - lifecycle events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        hideLabel(label: invalidMailLabel)
        hideLabel(label: invalidPassLabel)
    }
    
    // MARK: - functions, methods and actions
    
    func hideLabel(label: UILabel){
        label.isHidden = true
    }
    
    /**
     dismiss the keyboard after button "done" is tapped
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    /**
    present main tab of tab bar view controller
     */
    func goToTabBar(){
        let tabBarController = storyboard?.instantiateViewController(withIdentifier: Identificators.tabBarControllerId) as! TabBarViewController
        
        tabBarController.selectedViewController = tabBarController.viewControllers?[ Indexes.mainTabViewController]
        
        present(tabBarController, animated: true, completion: nil)
    }

    /**
     creates alert
     :param: message that alert will say
     */
    func createAlert(msg: String){
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    /**
     use FirebaseAuth to log in
     */
    func logIn(email: String, pass: String){
        
        Auth.auth().signIn(withEmail: email, password: pass) { user, error in
            if error != nil {
                print(error?.localizedDescription as Any)
                self.createAlert(msg: "No such user or wrong password!")
                return
            }
            self.goToTabBar()
        }
    }
    
    /**
     use FirebaseAuth to create account
     */
    func createAccount(email: String, pass: String){
        
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error != nil {
                print(error?.localizedDescription as Any)
                self.createAlert(msg: "Can't create an account! Network error. ")
                return
            }
            self.goToTabBar()
        }
    }
    
    /**
     depends of current state on view controller
     if view represent log in change it to create account
     if view represent create account swich it back to log in
     change the state variable "isLogin" and reset text fields
     */
    @IBAction func createAccountOrCancelTouchUp() {
        
        isLogin = !isLogin
        
        emailTextField.text = ""
        passwordTextField.text = ""
        
        if isLogin {
            loginOrCreateButton.setTitle("Log in", for: .normal)
            createAccOrCancelButton.setTitle("Create Account", for: .normal)
        }
        else {
            loginOrCreateButton.setTitle("Create", for: .normal)
            createAccOrCancelButton.setTitle("Cancel", for: .normal)
        }
    }
    
    
    /**
     safely unwrap text fields values and check if any of them is empty
     check if email is valid
     and finally if everything is correct login or create account (depend of current condition of screen)
     */
    @IBAction func loginOrCreateTouchUp() {
    
        guard let email  = emailTextField.text else {
            return
        }
        
        guard let pass  = passwordTextField.text else {
            return
        }
        
        if email != ""  {
            
            if !email.isValidEmail {
                invalidMailLabel.text = "not a valid email"
                invalidMailLabel.isHidden = false
                return
            }

            if  pass == "" {
                invalidPassLabel.isHidden = false
                return
            }
            
            if pass.count < 6 {
                invalidPassLabel.isHidden = false
                return
            }
        }
        else {
            invalidMailLabel.text = "Email can't be empty"
            invalidMailLabel.isHidden = false
            return
        }
        
        isLogin ? logIn(email: email, pass: pass) : createAccount(email: email, pass: pass)
    }

    @IBAction func passwordEditngChanged(_ sender: UITextField) {
        invalidPassLabel.isHidden = true
    }
    
    @IBAction func emailValueChanged(_ sender: UITextField) {
        invalidMailLabel.isHidden = true
    }
    
}
