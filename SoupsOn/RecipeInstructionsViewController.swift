import UIKit

class RecipeInstructionsViewController: UIViewController {
    
    var titleValue: String = "Steps"
    var dataFromPreviousView: [String: Any]?
    var recipeInstructions: [String] = []
    
    @IBOutlet weak var instructionsTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleValue
        
        print(dataFromPreviousView!)
        
        if let data = dataFromPreviousView {
            
            if data["recipeType"] as! K.RecipeType == .onlineRecipe {
                let recipe: Recipe = data["recipe"] as! Recipe
                recipeInstructions = recipe.analyzedInstructions[0].steps.map { String($0.number) + ". " + $0.step }
                
            } else if data["recipeType"] as! K.RecipeType == .userRecipe {
                let recipe: UserRecipe = data["recipe"] as! UserRecipe
                
                for i in 0..<recipe.directions.count {
                    recipeInstructions.append(String(i+1) + ". " + recipe.directions[i])
                }
                
            }
        }
        
        instructionsTV.delegate = self
        instructionsTV.dataSource = self
    }
}

extension String {
    func sliceMultipleTimes(from: String, to: String) -> [String] {
        components(separatedBy: from).dropFirst().compactMap { sub in
            (sub.range(of: to)?.lowerBound).flatMap { endRange in
                String(sub[sub.startIndex ..< endRange])
            }
        }
    }
}

extension RecipeInstructionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeInstructions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = instructionsTV.dequeueReusableCell(withIdentifier: "recipeInstructionCell") as! RecipeInstructionCell
        cell.instruction.text = recipeInstructions[indexPath.row]
        return cell
    }
    
}
