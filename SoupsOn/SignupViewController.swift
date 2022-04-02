//
//  SignupViewController.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-11.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var errorMsg: UILabel!
    
    var titleValue: String = "Signup"
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        
        signupBtn.layer.shadowColor = UIColor.gray.cgColor
        signupBtn.layer.shadowOpacity = 1
        signupBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        signupBtn.layer.shadowRadius = 5.0
    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
        
        if let email = emailTF.text, let password = passwordTF.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    // signup fail
                    self.errorMsg.text = e.localizedDescription
                } else {
                    // signup success
                    guard let userId = Auth.auth().currentUser?.uid else { return }
                    self.db.collection(K.FStore.usersCollection).document(userId).setData([
                        "recipes": []
                    ])
                    self.performSegue(withIdentifier: "SignupToRecipeCategories", sender: self)
                }
            }
        }
        
    }
}
