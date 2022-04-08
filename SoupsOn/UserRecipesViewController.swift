import UIKit
import Firebase
import FirebaseFirestoreSwift

class UserRecipesViewController: UIViewController {
    
    var titleValue: String = "My Recipes"
    let db = Firestore.firestore()
    var userRecipes: [UserRecipe] = []
    
    @IBOutlet weak var userRecipesTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        
        fetchDataFirestore()
        
        userRecipesTV.delegate = self
        userRecipesTV.dataSource = self
    }
    
    func fetchDataFirestore() {
        db.collection(K.FStore.usersCollection).addSnapshotListener { (querySnapshot, error) in
            if let e = error {
                print("Error retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    guard let userId = Auth.auth().currentUser?.uid else { return }
                    let userDoc = snapshotDocuments.first { $0.documentID == userId }
                    let recipeData: [[String: Any]] = userDoc!["recipes"]! as! [[String: Any]]
                    
                    self.userRecipes = []
                    for recipe in recipeData {
                        self.userRecipes.append(UserRecipe(
                            name: recipe["name"] as! String,
                            servings: recipe["servings"] as! String,
                            timeToMake: recipe["timeToMake"] as! String,
                            ingredients: recipe["ingredients"] as! [String],
                            directions: recipe["directions"] as! [String]
                        ))
                    }
                    
                    DispatchQueue.main.async {
                        print(self.userRecipes)
                        self.userRecipesTV.reloadData()
                    }
                }
            }
        }
    }
    
    func deleteRecipe(row: Int) {
        print("Delete")
        self.userRecipes.remove(at: row)

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
    
    func editRecipe(row: Int) {
        print("Edit")
        print(self.userRecipes[row])
    }
    
}

extension UserRecipesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userRecipesTV.dequeueReusableCell(withIdentifier: "userRecipeCell") as! UserRecipeCell
        cell.recipeName.text = userRecipes[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dataToSend: [String: Any] = [
            "recipe": userRecipes[indexPath.row],
            "recipeType": K.RecipeType.userRecipe
        ]
        self.performSegue(withIdentifier: "UserRecipesToRecipeDetails", sender: dataToSend)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "UserRecipesToRecipeDetails") {
            let destinationVC = segue.destination as! RecipeDetailsViewController
            destinationVC.dataFromPreviousView = sender as? [String: Any]
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.deleteRecipe(row: indexPath.row)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.editRecipe(row: indexPath.row)
            completionHandler(true)
        }
        editAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
}
