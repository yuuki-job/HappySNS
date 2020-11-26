//
//  LoadDBModel.swift
//  HappySNS
//
//  Created by 徳永勇希 on 2020/11/21.
//

import Foundation
import Firebase
class LoadDBModel{
    
    var dataSets = [DataSet]()
    let db = Firestore.firestore()
    
    func loadContents(){
        db.collection("datas").getDocuments() { (querySnapshot, err) in
            if let err = err {
                    print("err")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        print(data)
                        if let userID = data["userID"] as? String,let userName = data["userName"] as? String,let postComment = data["comment"] as? String,let postImageView = data["postImageView"] as? String{
                            
                            let newDataSet = DataSet(userID: userID, userName: userName, postComment: postComment, postImageView: postImageView)
                            
                            
                            self.dataSets.append(newDataSet)
                            //反転させて新し物が上から来るようになる。
                            self.dataSets.reverse()
                            
                    }
                }
            }
            
        }
    }
}
        
        
    

/*db.collection("datas").order(by: "postDate").addSnapshotListener {  (snapShot, error) in
    if error != nil{
        
        return
    }
    
    if let sanpShotDoc = snapShot?.documents{
        
        for doc in sanpShotDoc{
            let data = doc.data()
            print(data)
*/
