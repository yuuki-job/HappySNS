//
//  editConfigurationViewController.swift
//  HappySNS
//
//  Created by 徳永勇希 on 2021/01/12.
//

import UIKit

class EditConfigurationViewController: UIViewController {
    
    var ageArray = [Int](18...130)
    var prefectureArray = ["北海道", "青森県", "岩手県", "宮城県", "秋田県",
                      "山形県", "福島県", "茨城県", "栃木県", "群馬県",
                      "埼玉県", "千葉県", "東京都", "神奈川県","新潟県",
                      "富山県", "石川県", "福井県", "山梨県", "長野県",
                      "岐阜県", "静岡県", "愛知県", "三重県", "滋賀県",
                      "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県",
                      "鳥取県", "島根県", "岡山県", "広島県", "山口県",
                      "徳島県", "香川県", "愛媛県", "高知県", "福岡県",
                      "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県",
                      "鹿児島県", "沖縄県"]
    
    let agePickerView = UIPickerView()
    let prefecturePickerView = UIPickerView()
    
    @IBOutlet weak var ageSelectionTextField: UITextField!
    @IBOutlet weak var genderLabel: UISegmentedControl!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var prefectureSelectionTextField: UITextField!
    @IBOutlet weak var introductionTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Delegate設定
        agePickerView.delegate = self
        agePickerView.dataSource = self
        
        prefecturePickerView.delegate = self
        prefecturePickerView.dataSource = self
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // (年齢)インプットビュー設定
        ageSelectionTextField.inputView = agePickerView
        ageSelectionTextField.inputAccessoryView = toolbar
        
        // (県)インプットビュー設定
        prefectureSelectionTextField.inputView = prefecturePickerView
        prefectureSelectionTextField.inputAccessoryView = toolbar
        
        guard let ageData = UserDefaults.standard.object(forKey: "age") as? String,let prefectureData = UserDefaults.standard.object(forKey: "prefecture") as? String,let genderData = UserDefaults.standard.object(forKey: "gender") as? [String:Any],let IntroductionData = UserDefaults.standard.object(forKey: "introduction") as? String  else { return }
        ageSelectionTextField.text = ageData
        prefectureSelectionTextField.text = prefectureData
        genderLabel.selectedSegmentIndex = genderData["index"] as! Int
        introductionTextField.text = IntroductionData
        
     
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let prefecture = prefectureSelectionTextField.text,let age = ageSelectionTextField.text else {return}
        let genderData = ["title":genderLabel.titleForSegment(at: genderLabel.selectedSegmentIndex) as Any,"index":genderLabel.selectedSegmentIndex] as [String : Any]
        
        //firebaseにデータを送る
        let sendData = SendDBModel(prefecture: prefecture, age: Int(age) ?? 0, gender: genderData)
        sendData.sendProfileData()
    }
    // 決定ボタン押下
    @objc func done() {
        ageSelectionTextField.endEditing(true)
        prefectureSelectionTextField.endEditing(true)
    }
    @IBAction func saveButton(_ sender: Any) {
    
    UserDefaults.standard.setValue(ageSelectionTextField.text, forKey: "age")
        UserDefaults.standard.setValue(prefectureSelectionTextField.text, forKey: "prefecture")
        
        let genderData = ["title":genderLabel.titleForSegment(at: genderLabel.selectedSegmentIndex) as Any,"index":genderLabel.selectedSegmentIndex] as [String : Any]
        UserDefaults.standard.setValue(genderData, forKey: "gender")
        UserDefaults.standard.setValue(introductionTextField.text, forKey: "introduction")
       
        navigationController?.popViewController(animated: true)
    }
    @IBAction func imageViewTapButton(_ sender: Any) {
        
      doAlbum()
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
}
extension EditConfigurationViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if ageSelectionTextField.tag == 0{
            return ageArray.count
            
        }else {
            return prefectureArray.count
        }
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        if pickerView == agePickerView{
            return String(ageArray[row])
        }else{
            return prefectureArray[row]
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == agePickerView{
            ageSelectionTextField.text = String(ageArray[row])
        }else{
            prefectureSelectionTextField.text = prefectureArray[row]
        }
       
        
    }
    
}
extension EditConfigurationViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] as? UIImage != nil{
            
            let selectedImage = info[.originalImage] as! UIImage
            
            profileImageView.image = selectedImage
            let image = selectedImage.pngData()
            UserDefaults.standard.setValue(image, forKey: "imageData")
            
            
            picker.dismiss(animated: true, completion: nil)
            
        }
}
}
