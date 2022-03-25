//
//  RecipeRetriever.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-24.
//

import UIKit

class RecipeRetriever {
    let recipeURL = "https://api.spoonacular.com/food/products/search?apiKey=1b74a3d445ce440d9338c8a2ece20a10"
    
    func fetchRecipe(recipeName: String) {
        let urlString = "\(recipeURL)&query=\(recipeName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString!)
        }
    }
}
