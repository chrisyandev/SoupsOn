//
//  RecipeCategoriesViewController.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-24.
//

import UIKit

class RecipeCategoriesViewController: UIViewController {
    
    var titleValue: String = "Recipe Categories"
    var recipeRetriever = RecipeRetriever()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        
        recipeRetriever.fetchRecipe(recipeName: "Dinner")
    }
    
}
