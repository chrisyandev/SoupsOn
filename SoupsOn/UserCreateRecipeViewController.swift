import UIKit

class UserCreateRecipeViewController: UIViewController {
    
    var titleValue: String = "Create Recipe"
    var numOfIngredients: Int = 1
    var numOfDirections: Int = 1
    
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
    
    @objc func addIngredientRow() {
        numOfIngredients += 1
        ingredientsTV.reloadData()
    }
    
    @objc func addDirectionRow() {
        numOfDirections += 1
        directionsTV.reloadData()
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
            }
            return cell
        } else {
            let cell = directionsTV.dequeueReusableCell(withIdentifier: "directionTableCell") as! DirectionTableCell
            cell.addRowBtn.addTarget(self, action: #selector(addDirectionRow), for: .touchUpInside)
            if indexPath.row < (numOfDirections - 1) {
                cell.addRowBtn.isHidden = true
            }
            return cell
        }
    }
    
    
    
}
