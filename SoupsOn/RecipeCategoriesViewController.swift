//
//  RecipeCategoriesViewController.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-24.
//

import UIKit

class RecipeCategoriesViewController: UIViewController {
    
    var titleValue: String = "Recipe Categories"
    
    @IBOutlet weak var categoriesTV: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        
        categoriesTV.delegate = self
        categoriesTV.dataSource = self
    }
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        if let searchString: String = searchTF.text {
            let dataToSend: [String: Any] = ["query": searchString]
            self.performSegue(withIdentifier: "RecipeCategoriesToRecipeResults", sender: dataToSend)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "RecipeCategoriesToRecipeResults") {
            let destinationVC = segue.destination as! RecipeResultsViewController
            destinationVC.dataFromPreviousView = sender as? [String: Any]
        }
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
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dataToSend: [String: Any] = ["query": data[indexPath.row].name]
        self.performSegue(withIdentifier: "RecipeCategoriesToRecipeResults", sender: dataToSend)
    }
    
}

extension RecipeCategoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
}



