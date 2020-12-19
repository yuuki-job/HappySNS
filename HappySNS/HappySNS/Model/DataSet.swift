//
//  DataSet.swift
//  HappySNS
//
//  Created by 徳永勇希 on 2020/11/21.
//

import Foundation
class DataSet{
    var userID:String!
    var userName:String!
    var postComment:String?
    var postImageView:String?
    var currentTime:String!
    
    
    init(userID:String,userName:String,postComment:String,currentTime:String,postImageView:String) {
        
        self.userID = userID
        self.userName = userName
        self.postComment = postComment
        self.currentTime = currentTime
        self.postImageView = postImageView
    }
   
}
