//
//  LoginViewController.swift
//  HappySNS
//
//  Created by 徳永勇希 on 2020/12/26.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        Auth.auth().signInAnonymously() { (authResult, error) in
            let user = authResult?.user
            print(user)
            
            UserDefaults.standard.set(self.userTextField.text, forKey: "userName")
        
        let timeLineVC = self.storyboard?.instantiateViewController(identifier: "timeLineVC") as! TimeLineViewController
        
        self.navigationController?.pushViewController(timeLineVC, animated: true)
        }
    }
}
