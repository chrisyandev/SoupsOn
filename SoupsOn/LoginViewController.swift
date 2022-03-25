//
//  LoginViewController.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-11.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var forgotPwBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var twitterBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var errorMsg: UILabel!
    
    var titleValue: String = "Login"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        
        loginBtn.layer.shadowColor = UIColor.gray.cgColor
        loginBtn.layer.shadowOpacity = 1
        loginBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        loginBtn.layer.shadowRadius = 5.0
        
        facebookBtn.layer.shadowColor = UIColor.gray.cgColor
        facebookBtn.layer.shadowOpacity = 1
        facebookBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        facebookBtn.layer.shadowRadius = 5.0
        
        twitterBtn.layer.shadowColor = UIColor.gray.cgColor
        twitterBtn.layer.shadowOpacity = 1
        twitterBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        twitterBtn.layer.shadowRadius = 5.0
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTF.text, let password = passwordTF.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                
                if let e = error {
                    // login fail
                    self.errorMsg.text = e.localizedDescription
                } else {
                    // login success
                    self.performSegue(withIdentifier: "LoginToRecipeCategories", sender: self)
                }
            }
        }

    }
    
}
