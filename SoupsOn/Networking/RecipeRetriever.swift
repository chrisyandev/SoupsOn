//
//  RecipeRetriever.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-24.
//

import UIKit

class RecipeRetriever {
    let recipeURL = "https://api.spoonacular.com/recipes/random?apiKey=1b74a3d445ce440d9338c8a2ece20a10"
    
    func fetchRecipe(recipeName: String) {
        let urlString = "\(recipeURL)&number=1&tags=\(recipeName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // Create URL
        if let url = URL(string: urlString) {
            // Create URLSession
            let session = URLSession(configuration: .default)
            // Give session a task
            let task = session.dataTask(with: url) {  data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    // For debugging
//                    print(String(data: safeData, encoding: .utf8)!)
                    
                    // Convert JSON to object
                    self.parseJSON(recipeData: safeData)
                }
            }
            // Start task
            task.resume()
        }
    }
    
    func parseJSON(recipeData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RecipeData.self, from: recipeData)
            print(decodedData)
        } catch {
            print(error)
        }
    }
    
}
