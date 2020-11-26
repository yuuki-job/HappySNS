//
//  EditViewController.swift
//  HappySNS
//
//  Created by 徳永勇希 on 2020/11/21.
//

import UIKit

class EditViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolBarSetUp()
    }
    
    @IBAction func postButton(_ sender: Any) {
        
        //送信
        if textView.text?.isEmpty == true{
            return
        }
        let passImageViewData = imageView.image?.jpegData(compressionQuality: 0.01) ?? "".data(using: String.Encoding.utf8)!
        
        let sendDBModel = SendDBModel(userID: "", userName: "", postComment: textView.text, postImageView: passImageViewData )
        
        sendDBModel.sendData()
        //戻る
        self.navigationController?.popViewController(animated: true)
    }
    
    func toolBarSetUp(){
        // ボタンのサイズ
                let buttonSize: CGFloat = 24
        // ツールバーのインスタンスを作成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: buttonSize, height: 35))
       
                
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // UIButtonの作成
        let albumButton = UIButton(frame: CGRect(x: 200, y: 0, width: buttonSize, height: 10))
         
        // ボタンの背景に画像を設定
        albumButton.setBackgroundImage(UIImage(named: "album"), for: UIControl.State())
         
        // ボタンをクリックしたときに呼び出すメソッドを指定
        albumButton.addTarget(self, action: #selector(tapAlbumButton), for: .touchUpInside)
         
        // 作成したボタンを UIBarButtonItem として設定
        let albumButtonItem = UIBarButtonItem(customView: albumButton)
        
        albumButtonItem.customView?.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        albumButtonItem.customView?.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        //let albumButton = UIBarButtonItem(title: UIImage(named: "album"), style: .done, target: self, action: #selector(tapAlbumButton))
        let cancelButton = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(tapCancelButton))
        
        toolbar.setItems([flexibleItem,albumButtonItem,cancelButton], animated: true)
        textView.inputAccessoryView = toolbar
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] as? UIImage != nil{
            
            let selectedImage = info[.originalImage] as! UIImage
            
            imageView.image = selectedImage
            
            picker.dismiss(animated: true, completion: nil)
            
        }
    }
    func doAlbum(){
        
        let source:UIImagePickerController.SourceType = .photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = source
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
    @objc func tapAlbumButton(){
        doAlbum()
    }
    @objc func tapCancelButton(){
        textView.endEditing(true)
        
    }
    
}



