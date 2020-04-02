//
//  ViewController.swift
//  Fitness Prototype
//
//  Created by Allen Su on 2020/3/30.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
        
        navigationController?.navigationBar.isHidden = true
    }

    func setUpElements () {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }

}

