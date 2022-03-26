//
//  RecipeResultsViewController.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-25.
//

import UIKit

class RecipeResultsViewController: UIViewController, RecipeRetrieverDelegate {
    
    var titleValue: String = "Results"
    
    var receivedData: [String: Any]?
    var recipeRetriever = RecipeRetriever()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        recipeRetriever.delegate = self
        
        if let data = receivedData {
            let category = (data["chosenCategory"] as! String).lowercased() // "tags" query parameter must be lowercase
            recipeRetriever.fetchRecipe(recipeName: category)
        }
        
    }
    
    func didReceiveRecipeData(recipeData: RecipeData) {
        for recipe in recipeData.recipes {
            print(recipe.title)
            print(recipe.readyInMinutes)
            print(recipe.servings)
            print(recipe.extendedIngredients)
            print(recipe.instructions)
            print(recipe.image)
            print(recipe.spoonacularSourceUrl)
            print("===============================")
        }
    }
    
    func displayRecipes(_ recipeData: RecipeData) {

    }
    
}
