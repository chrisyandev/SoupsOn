import UIKit
import Firebase

class UserEditRecipeViewController: UIViewController {
    
    var titleValue: String = "Edit Recipe"
    var dataFromPreviousView: [String: Any]?
    let db = Firestore.firestore()
    var ingredientsData: [String] = [""]
    var directionsData: [String] = [""]
    var userRecipes: [UserRecipe]?
    
    @IBOutlet weak var editRecipeNameTF: UITextField!
    @IBOutlet weak var editServingsTF: UITextField!
    @IBOutlet weak var editTimeToMakeTF: UITextField!
    @IBOutlet weak var editIngredientsTV: UITableView!
    @IBOutlet weak var editDirectionsTV: UITableView!
    @IBOutlet weak var editErrorMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        
        if let data = dataFromPreviousView {
            
            if let userRecipes: [UserRecipe] = data["userRecipes"] as? [UserRecipe], let index: Int = data["index"] as? Int {
                self.userRecipes = userRecipes
                let recipe: UserRecipe = self.userRecipes![index]
                
                editRecipeNameTF.text = recipe.name
                editServingsTF.text = recipe.servings
                editTimeToMakeTF.text = recipe.timeToMake
                ingredientsData = recipe.ingredients
                directionsData = recipe.directions
            }
            
        }
        
        editIngredientsTV.delegate = self
        editIngredientsTV.dataSource = self
        editDirectionsTV.delegate = self
        editDirectionsTV.dataSource = self
    }
    
    @IBAction func saveChangesBtnPressed(_ sender: Any) {
        
        let recipeName = editRecipeNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let servings = editServingsTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let timeToMake = editTimeToMakeTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if recipeName == "" || servings == "" || timeToMake == "" {
            editErrorMsg.text = "Fields cannot be empty"
            
        } else {
            var ingredientsDataFiltered = ingredientsData
            ingredientsDataFiltered.removeAll { $0 == "" }
            var directionsDataFiltered = directionsData
            directionsDataFiltered.removeAll { $0 == "" }

            if var userRecipes = self.userRecipes, let data = self.dataFromPreviousView, let index: Int = data["index"] as? Int {
                
                userRecipes[index].name = recipeName!
                userRecipes[index].servings = servings!
                userRecipes[index].timeToMake = timeToMake!
                userRecipes[index].ingredients = ingredientsDataFiltered
                userRecipes[index].directions = directionsDataFiltered
                
                guard let userId = Auth.auth().currentUser?.uid else { return }
                let userDoc = db.collection(K.FStore.usersCollection).document(userId)
                
                userDoc.setData([
                    "recipes": []
                ])
                
                for recipe in userRecipes {
                    userDoc.updateData([
                        "recipes": FieldValue.arrayUnion([
                            [
                                "name": recipe.name as Any,
                                "servings": recipe.servings as Any,
                                "timeToMake": recipe.timeToMake as Any,
                                "ingredients": recipe.ingredients,
                                "directions": recipe.directions
                            ]
                        ])
                    ])
                }
            }
            
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc func ingredientTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            ingredientsData[textField.tag] = text
        } else {
            ingredientsData[textField.tag] = ""
        }
    }
    
    @objc func directionTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            directionsData[textField.tag] = text
        } else {
            directionsData[textField.tag] = ""
        }
    }
    
    @objc func addIngredientRow() {
        ingredientsData.append("")
        editIngredientsTV.reloadData()
        editIngredientsTV.scrollToRow(at: [0, ingredientsData.count - 1], at: .bottom, animated: true)
    }
    
    @objc func addDirectionRow() {
        directionsData.append("")
        editDirectionsTV.reloadData()
        editDirectionsTV.scrollToRow(at: [0, directionsData.count - 1], at: .bottom, animated: true)
    }
    
}


extension UserEditRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === editIngredientsTV {
            return ingredientsData.count
        } else {
            return directionsData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView === editIngredientsTV {
            let cell = editIngredientsTV.dequeueReusableCell(withIdentifier: "editIngredientTableCell") as! EditIngredientTableCell
            cell.editIngredientTF.text = ingredientsData[indexPath.row]
            cell.editIngredientTF.addTarget(self, action: #selector(ingredientTextFieldDidChange(_:)), for: .editingChanged)
            cell.editIngredientTF.tag = indexPath.row
            cell.editAddRowBtn.addTarget(self, action: #selector(addIngredientRow), for: .touchUpInside)
            if indexPath.row < (ingredientsData.count - 1) {
                cell.editAddRowBtn.isHidden = true
            } else {
                cell.editAddRowBtn.isHidden = false
            }
            return cell
        } else {
            let cell = editDirectionsTV.dequeueReusableCell(withIdentifier: "editDirectionTableCell") as! EditDirectionTableCell
            cell.editDirectionTF.text = directionsData[indexPath.row]
            cell.editDirectionTF.addTarget(self, action: #selector(directionTextFieldDidChange(_:)), for: .editingChanged)
            cell.editDirectionTF.tag = indexPath.row
            cell.editAddRowBtn.addTarget(self, action: #selector(addDirectionRow), for: .touchUpInside)
            if indexPath.row < (directionsData.count - 1) {
                cell.editAddRowBtn.isHidden = true
            } else {
               cell.editAddRowBtn.isHidden = false
            }
            return cell
        }
    }
    
}
