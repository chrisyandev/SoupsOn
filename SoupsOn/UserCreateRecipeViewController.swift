import UIKit

class UserCreateRecipeViewController: UIViewController {
    
    var titleValue: String = "Create Recipe"
    var numOfIngredients: Int = 1
    var numOfDirections: Int = 1
    
    @IBOutlet weak var recipeNameTF: UITextField!
    @IBOutlet weak var servingsTF: UITextField!
    @IBOutlet weak var timeToMakeTF: UITextField!
    @IBOutlet weak var ingredientsTV: UITableView!
    @IBOutlet weak var directionsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        
        ingredientsTV.delegate = self
        ingredientsTV.dataSource = self
        directionsTV.delegate = self
        directionsTV.dataSource = self
    }
    
    @IBAction func saveRecipeBtnPressed(_ sender: Any) {
        
    }
    
    @objc func addIngredientRow() {
        numOfIngredients += 1
        ingredientsTV.reloadData()
        ingredientsTV.scrollToRow(at: [0, numOfIngredients - 1], at: .bottom, animated: true)
    }
    
    @objc func addDirectionRow() {
        numOfDirections += 1
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
            cell.addRowBtn.addTarget(self, action: #selector(addIngredientRow), for: .touchUpInside)
            if indexPath.row < (numOfIngredients - 1) {
                cell.addRowBtn.isHidden = true
            } else {
                cell.addRowBtn.isHidden = false
            }
            return cell
        } else {
            let cell = directionsTV.dequeueReusableCell(withIdentifier: "directionTableCell") as! DirectionTableCell
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
