//
//  User.swift
//  Instagram
//
//  Created by admin on 08/03/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
class User {
    var email: String?
    var profileImageUrl: String?
    var username: String?
    var uid: String?
    
    init(uid: String, username: String, email: String, profileImageUrl: String) {
        self.email = email
        self.profileImageUrl = profileImageUrl
        self.username = username
        self.uid = uid
    }
    
}
