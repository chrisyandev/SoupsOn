//
//  RecipeData.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-25.
//

import UIKit

class RecipeData: Codable {
    let recipes: [Recipe]
}

class Recipe: Codable {
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let extendedIngredients: [Ingredient]
    let instructions: String
    let image: String
    let spoonacularSourceUrl: String
    let analyzedInstructions: [Instruction]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let image = try container.decodeIfPresent(String.self, forKey: .image) {
            self.image = image
        } else {
            self.image = ""
        }
        
        title = try container.decode(String.self, forKey: .title)
        readyInMinutes = try container.decode(Int.self, forKey: .readyInMinutes)
        servings = try container.decode(Int.self, forKey: .servings)
        extendedIngredients = try container.decode(Array.self, forKey: .extendedIngredients)
        instructions = try container.decode(String.self, forKey: .instructions)
        spoonacularSourceUrl = try container.decode(String.self, forKey: .spoonacularSourceUrl)
        analyzedInstructions = try container.decode(Array.self, forKey: .analyzedInstructions)
    }
}

class Ingredient: Codable {
    // original contains name and amount of ingredient
    let original: String
}

class Instruction: Codable {
    let steps: [Step]
}

class Step: Codable {
    let number: Int
    let step: String
}
