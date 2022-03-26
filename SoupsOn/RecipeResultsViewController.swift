//
//  RecipeResultsViewController.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-25.
//

import UIKit

class RecipeResultsViewController: UIViewController, RecipeRetrieverDelegate {
    
    var titleValue: String = "Results"
    var dataFromPreviousView: [String: Any]?
    var recipeRetriever: RecipeRetriever = RecipeRetriever()
    var recipeData: RecipeData? = nil
    
    @IBOutlet weak var recipesTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        
        recipesTV.delegate = self
        recipesTV.dataSource = self
        recipeRetriever.delegate = self
        
        if let data = dataFromPreviousView {
            let category = (data["chosenCategory"] as! String).lowercased() // "tags" query parameter must be lowercase
            recipeRetriever.fetchRecipe(recipeName: category)
        }
        
    }
    
    func didReceiveRecipeData(recipeData: RecipeData) {
//        for recipe in recipeData.recipes {
//            print(recipe.title)
//            print(recipe.readyInMinutes)
//            print(recipe.servings)
//            print(recipe.extendedIngredients)
//            print(recipe.instructions)
//            print(recipe.image)
//            print(recipe.spoonacularSourceUrl)
//            print("===============================")
//        }
        DispatchQueue.main.async {
            print(recipeData)
            self.recipeData = recipeData
            self.recipesTV.reloadData()
        }
    }
    
}

extension RecipeResultsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeCell
        
        if let recipes = recipeData?.recipes {
            cell.updateView(recipe: recipes[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // TODO
    }
    
}

extension RecipeResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if recipeData == nil {
            return 0
        } else {
            return (recipeData?.recipes.count)!
        }
    }
    
}
