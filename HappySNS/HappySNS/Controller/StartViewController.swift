//
//  StartViewController.swift
//  HappySNS
//
//  Created by 徳永勇希 on 2021/01/26.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func newAccountButton(_ sender: Any) {
        let signInVC = self.storyboard?.instantiateViewController(identifier: "signInVC") as! SignInViewController
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        let loginVC = self.storyboard?.instantiateViewController(identifier: "loginVC") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}
