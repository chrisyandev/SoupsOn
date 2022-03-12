//
//  ViewController.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loginBtn.layer.shadowColor = UIColor.gray.cgColor
        loginBtn.layer.shadowOpacity = 1
        loginBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        loginBtn.layer.shadowRadius = 5.0
        
        signupBtn.layer.shadowColor = UIColor.gray.cgColor
        signupBtn.layer.shadowOpacity = 1
        signupBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        signupBtn.layer.shadowRadius = 5.0
        
    }

}

