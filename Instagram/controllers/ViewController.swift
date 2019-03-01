//
//  ViewController.swift
//  Instagram
//
//  Created by admin on 19/02/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func signInTapped(_ sender: Any) {
        
        FirebaseService.signIn(email: emailTextField.text!, password: passwordTextField.text!) {
            self.performSegue(withIdentifier: "moveToProfile", sender: self)
            print('move to profile')
        }
        

    
    
}
}

