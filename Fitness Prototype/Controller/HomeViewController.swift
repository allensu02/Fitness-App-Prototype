//
//  HomeViewController.swift
//  Fitness Prototype
//
//  Created by Allen Su on 2020/3/30.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
class HomeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var goBackButton: UIButton!
    var list = ["age","sex", "height", "weight"]
    
    var step = 0
    
    let db = Firestore.firestore()
    
    var age: Int = -1
    var gender: String = ""
    var height: Int = -1
    var weight: Int = -1
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        // Do any additional setup after loading the view.
        
        
    }
    
    func setUp () {
        imageView.image = UIImage(named: "ageIcon")
        label.text = list[0]
        Utilities.styleLabel(label)
        pickerView.delegate = self
        pickerView.dataSource = self
        Utilities.styleFilledButton(goBackButton)
        Utilities.styleHollowButton(nextButton)
    }
    
    @IBAction func goBackPressed(_ sender: UIButton) {
        if step > 1 {
            step -= 1
            reloadItems(step)
        }
    }
    @IBAction func nextPressed(_ sender: UIButton) {
        if step < 2 {
            step += 1
            reloadItems(step)
        } else if step == 3 {
            var user = UserProfile(age: age, gender: gender, height: height, weight: weight, firstName: firstName, lastName: lastName, email: email, password: password)
            
            
        }
    }
    
    func addUserToDatabase () {
       // Create the user
       Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
           
           // Check for errors
           if err != nil {
               
               // There was an error creating the user
               self.showError("Error creating user")
           }
           else {
               
               // User was created successfully, now store the first name and last name
               let db = Firestore.firestore()
               
            db.collection("users").addDocument(data: ["firstname":self.firstName, "lastname":self.lastName, "uid": result!.user.uid ]) { (error) in
                   
                   if error != nil {
                       // Show error message
                       self.showError("Error saving user data")
                   }
               }
               
               // Transition to the home screen
           }
           
       }
    }
    
    func showError(_ message: String) {
        print(message)
    }
    
    func reloadItems (_ step : Int) {
        label.text = list[step]
        imageView.image = UIImage(named: "\(list[step])Icon")
        
        //set initial value of pickers
        switch step {
        case 0 :
            pickerView.selectRow(18, inComponent: 1, animated: true)
        case 1:
            pickerView.selectRow(1, inComponent: 1, animated: true)
        case 2:
            pickerView.selectRow(150, inComponent: 1, animated: true)
        case 3:
            pickerView.selectRow(75, inComponent: 1, animated: true)
            nextButton.titleLabel?.text = "Finish"
        default:
            break
        }
        
        pickerView.reloadAllComponents()
    }


}

extension HomeViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        //return the amount of rows for the picker
        switch step {
        case 0:
            return 100
        case 1:
            return 2
        case 2:
            return 200
        case 3:
            return 200
        default: return 0
        }
    }
    
    
}


extension HomeViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //return the text for the picker
        switch step {
        case 0:
            return "\(row)"
        case 1:
            if row == 1 {
                return "Male"
            } else {
                return "Female"
            }
        case 2:
            return "\(row) cm"
        case 3:
            return "\(row) KG"
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //sets values based on selected for picker
        switch step {
            case 0:
                age = row
            case 1:
                if row == 1 {
                    gender = "Male"
                } else {
                    gender = "Female"
                }
            case 2:
                height = row
            case 3:
                weight = row
            default: break
        }
    }
}
