//
//  LoadDBModel.swift
//  HappySNS
//
//  Created by 徳永勇希 on 2020/11/21.
//

import Foundation
import Firebase
import FirebaseFirestore
class LoadPostDataManager{
    
    var dataSets = [DataSet]()
    let db = Firestore.firestore()
    //let data = [String:Any]()
    /*func loadContents(){
     db.collection("datas").addSnapshotListener { (querySnapshot, err) in
     guard let snapshot = querySnapshot else {
     print("Error fetching snapshots: \(err!)")
     return
     }
     
     snapshot.documentChanges.forEach{new in
     if (new.type == .added){
     
     for document in snapshot.documents {
     let data = document.data()
     print(data)
     //追加タイプを受信したら先頭に追加する
     //self.dataSets.insert(new.document.data(), at: 0)
     guard let userID = data["userID"] as? String,let userName = data["userName"] as? String,let postComment = data["comment"] as? String else{return}
     let postImageView = data["postImageView"] as? String
     
     let newDataSet = Array(arrayLiteral: DataSet(userID: userID, userName: userName, postComment: postComment, postImageView: postImageView))
     
     
     self.dataSets = newDataSet
     //反転させて新し物が上から来るようになる。
     self.dataSets.reverse()
     print("新規メッセージを取得しました")
     
     }
     }
     if (new.type == .removed) {
     //削除タイプを受信したら削除する。とりあえず全部空にする
     //self.messageBox = []
     print("メッセージが削除されました")
     }
     
     }
     
     }
     
     }*/
    func getPostData(){
        var dataSet2:[DataSet] = []
        db.collection("datas").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    let data = document.data()
                    print(data)
                    
                    guard let userID = data["userID"] as? String,let userName = data["userName"] as? String,let postComment = data["comment"] as? String else{return}
                    let postImageView = data["postImageView"] as? String
                    
                    let newDataSet = DataSet(userID: userID, userName: userName, postComment: postComment, postImageView: postImageView)
                    
                    dataSet2.append(newDataSet)
                    
                    print("新規メッセージを取得しました")
                }
                
                self.dataSets = dataSet2
                //反転させて新し物が上から来るようになる。
                //self.dataSets.reverse()
                print(self.dataSets)
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
