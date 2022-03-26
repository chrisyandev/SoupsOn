//
//  RecipeResultsViewController.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-25.
//

import UIKit

class RecipeResultsViewController: UIViewController {
    
    var titleValue: String = "Results"
    
    var receivedData: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        
        if let data = receivedData {
            print(data["chosenCategory"]!)
        }
    }
    
}
