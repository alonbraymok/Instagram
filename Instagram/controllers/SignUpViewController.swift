//
//  SignUpViewController.swift
//  Instagram
//
//  Created by admin on 19/02/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class SignUpViewController: UIViewController {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.layer.cornerRadius = 40
        profileImage.clipsToBounds = true
        let tapTarget = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handelSelectProfileImageView))
        profileImage.addGestureRecognizer(tapTarget)
        profileImage.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    @objc func handelSelectProfileImageView(){
        print("asdasdasdas")
    }

    @IBAction func signupTapped(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { user, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            let ref = Database.database().reference()
            let userRef = ref.child("users")
            let uid = ref.childByAutoId().key
            let newUserRef = userRef.child(uid!)
            newUserRef.setValue(["username": self.usernameTextField.text!, "email": self.emailTextField.text!])
            
        }
    }
    
    
    @IBAction func dismissOnClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
