//
//  RecipeDetailsViewController.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-26.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    
    var titleValue: String = "Prep"
    var dataFromPreviousView: [String: Any]?

    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var timeToMake: UILabel!
    @IBOutlet weak var servings: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        
        if let data = dataFromPreviousView {
            
            if data["recipeType"] as! K.RecipeType == .onlineRecipe {
                
                let recipe: Recipe = data["recipe"] as! Recipe
                recipeName.text = "\(recipe.title)"
                timeToMake.text = "Ready in: \(recipe.readyInMinutes) minutes"
                servings.text = "Servings: \(recipe.servings)"
                
                let ingredientsFormatted = recipe.extendedIngredients.map({ $0.original }).joined(separator: ", ")
                ingredients.text = "Ingredients: \(ingredientsFormatted)"
                
                
            } else if data["recipeType"] as! K.RecipeType == .userRecipe {
                
                let recipe: UserRecipe = data["recipe"] as! UserRecipe
                recipeName.text = recipe.name
                timeToMake.text = "Ready in: \(recipe.timeToMake)"
                servings.text = "Servings: \(recipe.servings)"
                ingredients.text = "Ingredients: \(recipe.ingredients.joined(separator: ", "))"
                
            }

        }
        
    }
}
