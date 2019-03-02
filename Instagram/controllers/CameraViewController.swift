//
//  CameraViewController.swift
//  Instagram
//
//  Created by admin on 19/02/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase


class CameraViewController: UIViewController {

    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapTarget = UITapGestureRecognizer(target: self, action: #selector(CameraViewController.handelSelectPhoto))
        photo.addGestureRecognizer(tapTarget)
        photo.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    @objc func handelSelectPhoto(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController,animated: true, completion: nil)
    }
    
    @IBAction func postButtonTapped(_ sender: Any) {
        var data = Data()
        data = self.photo.image!.pngData()!
        
        let ref = Database.database().reference()
        let photoId = ref.childByAutoId().key
        
        let imageRef = Storage.storage().reference(forURL: "gs://instagram-753b8.appspot.com/").child("posts").child(photoId!)
        _ = imageRef.putData(data, metadata: nil, completion: {(metadata, error) in
            if error != nil {
                return
            }
            _ = imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {  return }// Uh-oh, an error occurred!
                
                let photoUrl = downloadURL.absoluteString
                self.sendDataToDatabase(photoUrl: photoUrl)
            }
            
        })
    }
    func sendDataToDatabase(photoUrl: String){
       let ref = Database.database().reference()
        let postReference = ref.child("posts")
        let newPhotoId = postReference.childByAutoId().key
        let newPostReference = postReference.child(newPhotoId!)
        newPostReference.setValue(["photoUrl": photoUrl, "caption": captionTextView.text!])
        self.captionTextView.text = "Write here photo description"
        self.photo.image = UIImage(named: "upload_image")
        self.tabBarController?.selectedIndex = 0
    }
    
    
    
    @IBAction func clearData(_ sender: Any) {
        self.captionTextView.text = "Write here photo description"
        self.photo.image = UIImage(named: "upload_image")
    }
    
    
    
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            selectedImage = image
            photo.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
