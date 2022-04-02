import UIKit
import Firebase

class UserCreateRecipeViewController: UIViewController {
    
    var titleValue: String = "Create Recipe"
    let db = Firestore.firestore()
    var numOfIngredients: Int = 1
    var numOfDirections: Int = 1
    var ingredientsData: [String] = [""]
    var directionsData: [String] = [""]
    
    @IBOutlet weak var recipeNameTF: UITextField!
    @IBOutlet weak var servingsTF: UITextField!
    @IBOutlet weak var timeToMakeTF: UITextField!
    @IBOutlet weak var ingredientsTV: UITableView!
    @IBOutlet weak var directionsTV: UITableView!
    @IBOutlet weak var errorMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        
        ingredientsTV.delegate = self
        ingredientsTV.dataSource = self
        directionsTV.delegate = self
        directionsTV.dataSource = self
    }
    
    @IBAction func saveRecipeBtnPressed(_ sender: Any) {
        let recipeName = recipeNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let servings = servingsTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let timeToMake = timeToMakeTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if recipeName == "" || servings == "" || timeToMake == "" {
            errorMsg.text = "Fields cannot be empty"
        } else {
            var ingredientsDataFiltered = ingredientsData
            ingredientsDataFiltered.removeAll { $0 == "" }
            var directionsDataFiltered = directionsData
            directionsDataFiltered.removeAll { $0 == "" }

            guard let userId = Auth.auth().currentUser?.uid else { return }
            let userDoc = db.collection(K.FStore.usersCollection).document(userId)
            userDoc.updateData([
                "recipes": FieldValue.arrayUnion([
                    [
                        "name": recipeName as Any,
                        "servings": servings as Any,
                        "timeToMake": timeToMake as Any,
                        "ingredients": ingredientsDataFiltered,
                        "directions": directionsDataFiltered
                    ]
                ])
            ])
        }
        
    }
    
    @objc func ingredientTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            ingredientsData[textField.tag] = text
        } else {
            ingredientsData[textField.tag] = ""
        }
        print(ingredientsData)
    }
    
    @objc func directionTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            directionsData[textField.tag] = text
        } else {
            directionsData[textField.tag] = ""
        }
        print(directionsData)
    }
    
    @objc func addIngredientRow() {
        numOfIngredients += 1
        ingredientsData.append("")
        ingredientsTV.reloadData()
        ingredientsTV.scrollToRow(at: [0, numOfIngredients - 1], at: .bottom, animated: true)
    }
    
    @objc func addDirectionRow() {
        numOfDirections += 1
        directionsData.append("")
        directionsTV.reloadData()
        directionsTV.scrollToRow(at: [0, numOfDirections - 1], at: .bottom, animated: true)
    }
    
}


extension UserCreateRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === ingredientsTV {
            return numOfIngredients
        } else {
            return numOfDirections
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView === ingredientsTV {
            let cell = ingredientsTV.dequeueReusableCell(withIdentifier: "ingredientTableCell") as! IngredientTableCell
            cell.ingredientTF.text = ingredientsData[indexPath.row]
            cell.ingredientTF.addTarget(self, action: #selector(ingredientTextFieldDidChange(_:)), for: .editingChanged)
            cell.ingredientTF.tag = indexPath.row
            cell.addRowBtn.addTarget(self, action: #selector(addIngredientRow), for: .touchUpInside)
            if indexPath.row < (numOfIngredients - 1) {
                cell.addRowBtn.isHidden = true
            } else {
                cell.addRowBtn.isHidden = false
            }
            return cell
        } else {
            let cell = directionsTV.dequeueReusableCell(withIdentifier: "directionTableCell") as! DirectionTableCell
            cell.directionTF.text = directionsData[indexPath.row]
            cell.directionTF.addTarget(self, action: #selector(directionTextFieldDidChange(_:)), for: .editingChanged)
            cell.directionTF.tag = indexPath.row
            cell.addRowBtn.addTarget(self, action: #selector(addDirectionRow), for: .touchUpInside)
            if indexPath.row < (numOfDirections - 1) {
                cell.addRowBtn.isHidden = true
            } else {
               cell.addRowBtn.isHidden = false
            }
            return cell
        }
    }
    
}
