//
//  LoginViewController.swift
//  HappySNS
//
//  Created by 徳永勇希 on 2020/12/26.
//

import UIKit
import FirebaseAuth
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        guard let userName = userNameTextField.text,let mail = mailTextField.text,let password = passwordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: mail, password:password) { (result, error) in
            if let error = error {
                print(error)
                return
            }
            if let result = result {
                print(result)
                Firestore.firestore().collection("users").document(mail).setData(["email" : mail, "userName" : userName])
                let fpVC = self.storyboard?.instantiateViewController(identifier: "fpVC") as! FirstProfileViewController
                self.navigationController?.pushViewController(fpVC, animated: true)
            }
            
        }
    }
}
