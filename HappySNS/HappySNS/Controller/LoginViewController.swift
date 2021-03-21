//
//  LoginViewController.swift
//  HappySNS
//
//  Created by 徳永勇希 on 2021/01/26.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let userName = userNameTextField.text,let mail = mailTextField.text,let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: mail, password: password) { (result, error) in
            
            if let error = error{
                print(error)
            }
            if let result = result{
                print(result)
                
                Firestore.firestore().collection("user").document(mail).getDocument { (document, error) in
                    if let error = error{
                        print(error)
                    }
                    if let document = document {
                        //guard let data = document.data() else{return}
                        //let name = data["userName"] as! String
                        
                        let timeLineVC = self.storyboard?.instantiateViewController(identifier: "timeLineVC") as! TimeLineViewController
                        
                        self.navigationController?.pushViewController(timeLineVC, animated: true)
                    }
                }
            }
        }
    }
}
