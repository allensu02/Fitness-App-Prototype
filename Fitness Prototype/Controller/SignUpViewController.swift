//
//  SignUpViewController.swift
//  Fitness Prototype
//
//  Created by Allen Su on 2020/3/30.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var genderPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false

        setUpElements()
    }
    

    func setUpElements() {
        //hide error label
        errorLabel.alpha = 0
        //style elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }

    
    func validateFields () -> String? {
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            {
            return "Please fill in all fields"
        }
        if !Utilities.isEmailValid((emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!) {
           return "Please enter a valid email address"
        }
       
        if !Utilities.isPasswordValid((passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))) {
            return "Please make sure your password is at least 8 characters, contains a special character, and a number."
        }
        
        
        return nil
    }
    @IBAction func signUpTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            //show error message
            showError(error!)
        } else {
            //
            let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            //create user
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
                //check for error
                if let err = error {
                    self.showError("Error creating user")
                } else {
                    //user created
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname" : firstName, "lastname": lastName, "email" : email,"uid": result?.user.uid]) { (error) in
                        
                        if error != nil {
                            self.showError("User data couldn't be saved")
                        }
                    }
                    //transition to birthday screen
                    self.view.window?.rootViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.birthdayViewController) as! SignUpViewController
                }
            }
            
            
            
        }
     
    }
    func showError (_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as! HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    
    
}
