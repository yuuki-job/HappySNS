//
//  ConfigurationViewController.swift
//  HappySNS
//
//  Created by 徳永勇希 on 2021/01/10.
//

import UIKit

class SeeConfigurationViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var prefectureLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    
    var newProfileData = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = 25
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let ageData = UserDefaults.standard.object(forKey: "age") as? String,let prefectureData = UserDefaults.standard.object(forKey: "prefecture") as? String,let genderData = UserDefaults.standard.object(forKey: "gender") as? [String:Any],let imageData = UserDefaults.standard.object(forKey: "imageData") as? Data   else { return }
        guard let introductionData = UserDefaults.standard.object(forKey: "introduction") as? String else { return  }
        ageLabel.text = ageData
        prefectureLabel.text = prefectureData
        genderLabel.text = genderData["title"] as? String
        profileImageView.image = UIImage(data: imageData)
        introductionLabel.text = introductionData
    }
    
    @IBAction func editProfileButton(_ sender: Any) {
        
        let editConfigurationVC = self.storyboard?.instantiateViewController(identifier: "editConfigurationVC") as! EditConfigurationViewController
        
        navigationController?.pushViewController(editConfigurationVC, animated: true)
        
    }
    
}
