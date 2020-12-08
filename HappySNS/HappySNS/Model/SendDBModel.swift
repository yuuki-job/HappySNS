//
//  SendDBModel.swift
//  HappySNS
//
//  Created by 徳永勇希 on 2020/11/21.
//

import Foundation
import Firebase
import FirebaseStorage

class SendDBModel{
    var userID = String()
    var userName = String()
    var postComment = String()
    var postImageView = Data()
    
    var db = Firestore.firestore()
    
    
    
    //送信機能を集約する
    init() {
        
    }
    
    init(userID:String,userName:String,postComment:String,postImageView:Data) {
        self.userID = userID
        self.userName = userName
        self.postComment = postComment
        self.postImageView = postImageView
        
    }
    
    func sendData(){
        
        self.db.collection("datas").document().setData(["userID":self.userID,"userName":self.userName,"comment":self.postComment,"postImageView":self.postImageView])
        
        
    }
    
    
}


