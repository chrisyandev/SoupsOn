//
//  RecipeData.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-25.
//

import UIKit

struct RecipeData: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable {
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let extendedIngredients: [Ingredient]
    let instructions: String
    let image: String
    let spoonacularSourceUrl: String
}

struct Ingredient: Decodable {
    // original contains name and amount of ingredient
    let original: String
}

