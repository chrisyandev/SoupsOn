//
//  RecipeCell.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-26.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    
    func updateView(recipe: Recipe) {
        if let imageURL = URL(string: recipe.image) {
            let data = try? Data(contentsOf: imageURL)
            recipeImage.image = UIImage(data: data!)
        } else {
            recipeImage.image = UIImage(named: "soup-logo")
        }
        recipeName.text = recipe.title
    }
    
}

// Asynchronous image loading
//extension UIImageView {
//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}
