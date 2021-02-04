//
//  LoadDBModel.swift
//  HappySNS
//
//  Created by 徳永勇希 on 2020/11/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import PKHUD
class LoadPostDataManager{
    
    var dataSets = [DataSet]()
    {
        willSet{
            print("dataSetsCount  \(newValue.count)")
        }
        
    }
    var prefectureData = String()
    var ageData = Int()
    var gender = String()
    
    
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
    func getPostData(view:UIView){
        HUD.show(.progress, onView: view)
        var dataSet2:[DataSet] = []
        db.collection("user").document((Auth.auth().currentUser?.email)!).collection("data").order(by: "currentTime").addSnapshotListener
        { (querySnapshot, err) in
            
            
            if let err = err {
                
                HUD.hide { (_) in
                    HUD.flash(.error, delay: 1)
                    
                    print("Error getting documents: \(err)")
                }
            } else {
                
                for document in querySnapshot!.documents {
                    let data = document.data()
                    
                    guard let userID = data["userID"] as? String,let userName = data["userName"] as? String,let currentTime = data["currentTime"] as? String,let postComment = data["comment"] as? String,let postImageView = data["postImageView"] as? String else{return}
                    
                    print(postComment)
                    
                    let newDataSet = DataSet(userID: userID, userName: userName, postComment: postComment, currentTime: currentTime, postImageView: postImageView )
                    dataSet2.append(newDataSet)
                    
                    HUD.hide { (_) in
                        HUD.flash(.success, delay: 1)
                    }
                    print("新規メッセージを取得しました")
                    
                    
                    self.dataSets = dataSet2
                    //反転させて新し物が上から来るようになる。
                    self.dataSets.reverse()
                    //print(self.dataSets)
                }
            }
        }
    }
    
    func getProfileData(){
        
        Firestore.firestore().collection("user").document((Auth.auth().currentUser?.email)!).collection("data").document("profileData").getDocument { (documentData, error) in
            if let error = error{
                print(error)
            }else{
                guard let data = documentData?.data() else{return}
                
                guard let prefecture = data["prefecture"] as? String,let age = data["age"] as? Int,let gender = data["gender"] as? String else {return}
                let newData = DataSet(prefecture: prefecture, age: age, gender: gender)
                self.prefectureData = newData.prefecture
                self.ageData = newData.age
                self.gender = newData.gender
            }
        }
    }
    /*func downloadImage(){
     var imageDatas:[DataSet] = []
     
     let dataRef = Firestore.firestore().collection("datas").document().path
     let dataRefId = String(dataRef.dropFirst(5))
     
     Storage.storage().reference().child("image.jpg").child(dataRefId).downloadURL { (url, error) in
     if let error = error {
     print(error)
     } else {
     guard let urlString = url?.absoluteString else{return}
     print(urlString)
     let imageData = DataSet(postImageView: urlString)
     imageDatas.append(imageData)
     self.dataSets = imageDatas
     
     }
     }
     
     }*/
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

