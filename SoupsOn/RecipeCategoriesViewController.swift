//
//  RecipeCategoriesViewController.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-24.
//

import UIKit

class RecipeCategoriesViewController: UIViewController {
    
    var titleValue: String = "Recipe Categories"
    var categoryWidth: Double = UIScreen.main.bounds.width * 0.4
    
    @IBOutlet weak var categoriesCV: UICollectionView!
    @IBOutlet weak var searchTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: categoryWidth, height: categoryWidth)
        categoriesCV.collectionViewLayout = layout
        
        categoriesCV.delegate = self
        categoriesCV.dataSource = self
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

extension RecipeCategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCV.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell

        cell.updateView(category: data[indexPath.item])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: categoryWidth, height: categoryWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.alpha = 0.5
            cell.contentView.alpha = 0.5
            UIView.animate(withDuration: 1.0) {
                cell.alpha = 1.0
                cell.contentView.alpha = 1.0
            }
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let dataToSend: [String: Any] = ["query": data[indexPath.item].name]
        self.performSegue(withIdentifier: "RecipeCategoriesToRecipeResults", sender: dataToSend)
    }
    
}




