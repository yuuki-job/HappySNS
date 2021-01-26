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

        // Do any additional setup after loading the view.
    }
    
@IBAction func newAccountButton(_ sender: Any) {
        
        let signInVC = self.storyboard?.instantiateViewController(identifier: "signInVC") as! SignInViewController
    self.navigationController?.pushViewController(signInVC, animated: true)
    }
    @IBAction func loginButton(_ sender: Any) {
        
        let loginVC = self.storyboard?.instantiateViewController(identifier: "loginVC") as! LoginViewController
    self.navigationController?.pushViewController(loginVC, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
