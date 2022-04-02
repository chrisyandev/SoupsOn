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
        
        db.collection(K.FStore.usersCollection).getDocuments { (querySnapshot, error) in
            if let e = error {
                print("Error retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    guard let userId = Auth.auth().currentUser?.uid else { return }
                    let userDoc = snapshotDocuments.first { $0.documentID == userId }
                    let recipeData: [[String: Any]] = userDoc!["recipes"]! as! [[String: Any]]
                    
//                    print(recipe["name"] as! String)
//                    print(recipe["servings"] as! String)
//                    print(recipe["timeToMake"] as! String)
//                    print(recipe["ingredients"] as! [String])
//                    print(recipe["directions"] as! [String])
                    
                    for recipe in recipeData {
                        self.userRecipes.append(UserRecipe(
                            name: recipe["name"] as! String,
                            servings: recipe["servings"] as! String,
                            timeToMake: recipe["timeToMake"] as! String,
                            ingredients: recipe["ingredients"] as! [String],
                            directions: recipe["directions"] as! [String]
                        ))
                    }
                }
            }
        }
        
        
        userRecipesTV.delegate = self
        userRecipesTV.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(self.userRecipes)
        userRecipesTV.reloadData()
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
    
}
