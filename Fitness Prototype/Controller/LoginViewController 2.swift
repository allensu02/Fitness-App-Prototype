//
//  LoginViewController.swift
//  Fitness Prototype
//
//  Created by Allen Su on 2020/3/30.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false

        setUpElements()
    }
    

    func setUpElements() {
        //hide error label
        errorLabel.alpha = 0
        
        //style elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(logInButton)
    }

    @IBAction func loginTapped(_ sender: Any) {
        
        if let error = validateFields() {
            showError(error)
        } else {
            Auth.auth().signIn(withEmail: (emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!, password: (passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!) { (result, error) in
                if let err = error {
                    self.showError("Incorrect username or password")
                } else {
                    self.transitionToHome()
                }
                
                
            }
        }
    }
    
    func validateFields() -> String?{
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        return nil
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as! HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }

    
}
