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
    var prefecture = String()
    var age = Int()
    var gender = [String:Any]()
    
    
    
    var db = Firestore.firestore()
    
    init(userID:String,userName:String,postComment:String,currentTime:String,postImageView:Data) {
        self.userID = userID
        self.userName = userName
        self.postComment = postComment
        self.postImageView = postImageView
        self.currentTime = currentTime
    }
    
    init(prefecture:String,age:Int,gender:[String:Any]) {
        self.prefecture = prefecture
        self.age = age
        self.gender = gender
    }
    
    func sendData() {
        let imageRef = Storage.storage().reference().child("images").child(UUID().uuidString)
        imageRef.putData(postImageView, metadata: nil) { (StorageMetadata, error) in
            guard StorageMetadata != nil else{
                print("upload error!")
                return
            }
            print("upload successful!")
            imageRef.downloadURL { (url, error) in
                if error != nil{
                    return
                }
                self.db.collection("user").document((Auth.auth().currentUser?.email)!).collection("data").document("userData").setData(["userID":self.userID,"userName":self.userName,"comment":self.postComment,"postImageView":url?.absoluteString as Any,"currentTime":self.currentTime])
            }
        }
    }
    func sendProfileData() {
        let imageRef = Storage.storage().reference().child("images").child(UUID().uuidString)
        imageRef.putData(postImageView, metadata: nil) { (StorageMetadata, error) in
            guard StorageMetadata != nil else{
                print("upload error!")
                return
            }
            print("upload successful!")
            imageRef.downloadURL { (url, error) in
                if error != nil{
                    return
                }
                self.db.collection("user").document((Auth.auth().currentUser?.email)!).collection("data").document("profileData").setData(["prefecture":self.prefecture,"age":self.age,"gender":self.gender])
                
            }
        }
    }
    
    
    /*class func sendImageData(postImageView:Data){
     
     let dataRef = Firestore.firestore().collection("datas").document().path
     let dataRefId = String(dataRef.dropFirst(5))
     
     Storage.storage().reference().child("image.jpg").child(dataRefId).putData(postImageView, metadata: nil) { (StorageMetadata, error) in
     //let ref = storageRef.child("image.jpg/file.png")
     
     guard StorageMetadata != nil else{
     print("upload error!")
     
     return
     }
     print("upload successful!")
     
     
     }
     
     
     }*/
}



