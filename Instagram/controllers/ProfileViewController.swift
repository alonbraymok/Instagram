//
//  ProfileViewController.swift
//  Instagram
//
//  Created by admin on 19/02/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage

class ProfileViewController: UIViewController, UITableViewDelegate {

   
    var posts = [Post]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
        //loadPosts()
        // Do any additional setup after loading the view.
    }
    
// 
//    func loadPosts(){
//        Database.database().reference().child("posts").observe(.childAdded) { (DataSnapshot) in
//            if let dict = DataSnapshot.value as? [String: Any]{
//                let caption = dict["caption"] as! String
//                let photoUrl = dict["photoUrl"] as! String
//                let uid = dict["uid"] as! String
//                let post = Post(uid: uid, caption: caption, photoUrl: photoUrl)
//                self.posts.append(post)
//                print(self.posts)
//                self.tableview.reloadData()
//            }
//        }
//    }
 

}


