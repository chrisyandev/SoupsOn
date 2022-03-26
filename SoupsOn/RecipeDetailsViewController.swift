//
//  RecipeDetailsViewController.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-26.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    
    var titleValue: String = "Recipe"
    var dataFromPreviousView: [String: Any]?

    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var readyInMinutes: UILabel!
    @IBOutlet weak var servings: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var instructions: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        
        if let data = dataFromPreviousView {
            let recipe: Recipe = data["recipe"] as! Recipe
            recipeName.text = "\(recipe.title)"
            readyInMinutes.text = "Ready in: \(recipe.readyInMinutes) minutes"
            servings.text = "\(recipe.servings) servings"
            
            let ingredientsFormatted = recipe.extendedIngredients.map({ $0.original }).joined(separator: ", ")
            ingredients.text = "Ingredients: \(ingredientsFormatted)"
            
            let instructionsFormatted = recipe.instructions.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
            instructions.text = "Instructions: \(instructionsFormatted)"
        }
        
    }
}
