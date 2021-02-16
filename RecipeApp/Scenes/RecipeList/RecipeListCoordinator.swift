import UIKit

enum RecipeListAction {
    case recipeDetail(id: Int)
    case addRecipeForm
}

protocol RecipeListCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: RecipeListAction)
}

final class RecipeListCoordinator {
    weak var viewController: UIViewController?
}

// MARK: - RecipeListCoordinating
extension RecipeListCoordinator: RecipeListCoordinating {
    func perform(action: RecipeListAction) {
        switch action {
        case .recipeDetail(let id):
            viewController?.navigationController?.pushViewController(RecipeDetailFactory.make(id: id), animated: true)
        case .addRecipeForm:
            viewController?.navigationController?.pushViewController(RecipeFormFactory.make(), animated: true)
        }
    }
}
