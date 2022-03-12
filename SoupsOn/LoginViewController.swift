//
//  LoginViewController.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-11.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var forgotPwBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var twitterBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
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
}
