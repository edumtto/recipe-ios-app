import UIKit

enum RecipeDetailAction {
    case edit(Recipe)
}

protocol RecipeDetailCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: RecipeDetailAction)
}

final class RecipeDetailCoordinator {
    weak var viewController: UIViewController?
}

// MARK: - RecipeDetailCoordinating
extension RecipeDetailCoordinator: RecipeDetailCoordinating {
    func perform(action: RecipeDetailAction) {
        switch action {
        case .edit(let recipe):
            let editForm = RecipeFormFactory.make(recipe: recipe)
            viewController?.navigationController?.pushViewController(editForm, animated: true)
        }
    }
}
