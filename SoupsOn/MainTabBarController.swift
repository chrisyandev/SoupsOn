import UIKit

class MainTabBarController: UITabBarController {
    
    var dataFromPreviousView: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewControllers = viewControllers else {
            return
        }
        
        for viewController in viewControllers {
            
            if let recipeDetailsViewController = viewController as? RecipeDetailsViewController {
                recipeDetailsViewController.dataFromPreviousView = self.dataFromPreviousView
            } else if let recipeInstructionsViewController = viewController as? RecipeInstructionsViewController {
                recipeInstructionsViewController.dataFromPreviousView = self.dataFromPreviousView
            }
        }
    }
    
}
