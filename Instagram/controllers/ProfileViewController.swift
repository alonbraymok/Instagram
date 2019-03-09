//
//  ProfileViewController.swift
//  Instagram
//
//  Created by admin on 19/02/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import SDWebImage

class ProfileViewController: UIViewController, UITableViewDelegate {

   
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    var posts = [Post]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.rowHeight = UITableView.automaticDimension
        let currentUserId = Auth.auth().currentUser?.uid
        self.loadUserInfo(id: currentUserId)
        loadPosts()
  
    }
    

    func loadPosts(){
        let currentUserId = Auth.auth().currentUser?.uid
        Database.database().reference().child("posts").observe(.childAdded) { (DataSnapshot) in
            if let dict = DataSnapshot.value as? [String: Any]{
                let caption = dict["caption"] as! String
                let photoUrl = dict["photoUrl"] as! String
                let uid = dict["uid"] as! String
                let post = Post(uid: uid, caption: caption, photoUrl: photoUrl)
                
                if(currentUserId == post.uid){
                    self.posts.append(post)
                }
                self.tableview.reloadData()
            }
        }
    }
    func loadUserInfo(id: String?){
        if let uid = id {
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (sanpshot) in
                if let dict = sanpshot.value as? [String: Any]{
                    let user = User(uid: dict["uid"] as! String,username: dict["username"] as! String, email: dict["email"] as! String, profileImageUrl: dict["profileImageUrl"] as! String)
                    self.usernameLabel.text = user.username
                    if let photoUrlString = user.profileImageUrl{
                        let photoUrl = URL(string: photoUrlString)
                        self.profileImageView.sd_setImage(with: photoUrl) { (image, error, chace, url) in
                            self.profileImageView.layer.cornerRadius = 60
                            self.profileImageView.clipsToBounds = true
                        }
                    }
                }
            }
        }
    }
 

}
extension ProfileViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300;//Choose your custom row height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "profilePostCell", for: indexPath) as! ProfileTableViewCell
        
        let post = posts[indexPath.row]
        
        cell.caption.text = post.caption
        if let photoUrlString = post.photoUrl{
            let photoUrl = URL(string: photoUrlString)
            cell.postImage.sd_setImage(with: photoUrl) { (image, error, chace, url) in
                
            }
        }
        cell.postImage.layer.cornerRadius = 4
        cell.postImage.clipsToBounds = true
        cell.backgroundView = UIImageView(image: UIImage(named: "appBackground"))
        return cell
    }
    


}


