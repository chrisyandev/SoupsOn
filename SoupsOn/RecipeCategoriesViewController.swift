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
    
    @IBOutlet weak var categoriesTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        
        recipeRetriever.fetchRecipe(recipeName: "dinner")
        
        categoriesTV.delegate = self
        categoriesTV.dataSource = self
    }
    
}

let data = Categories.categoriesList

extension RecipeCategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        
        cell.updateView(category: data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO
    }
    
}

extension RecipeCategoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
}

