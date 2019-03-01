//
//  FirebaseService.swift
//  Instagram
//
//  Created by admin on 01/03/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class FirebaseService {
    
    
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void){
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                return
                    print("log in not seccesfully")
            }
            onSuccess()
        }
        
    }
    
    
    
}
