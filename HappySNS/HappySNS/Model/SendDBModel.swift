//
//  SendDBModel.swift
//  HappySNS
//
//  Created by 徳永勇希 on 2020/11/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

class SendDBModel{
    var userID = String()
    var userName = String()
    var postComment = String()
    var postImageView = Data()
    var currentTime = String()
    
    var db = Firestore.firestore()
    
    init(userID:String,userName:String,postComment:String,postImageView:Data,currentTime:String) {
        self.userID = userID
        self.userName = userName
        self.postComment = postComment
        self.postImageView = postImageView
        self.currentTime = currentTime
    }
    
    func sendData(){
        
        self.db.collection("datas").document().setData(["userID":self.userID,"userName":self.userName,"comment":self.postComment,"postImageView":self.postImageView,"currentTime":self.currentTime])
        
    }
    class func sendImageData(postImageView:Data){
        let storageRef = Storage.storage().reference()
        let ref = storageRef.child("image.jpg/file.png")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        ref.putData(postImageView, metadata: metadata) { _, error in
            if (error != nil) {
                print("upload error!")
            } else {
                print("upload successful!")
            }
            
        }
    }
}


