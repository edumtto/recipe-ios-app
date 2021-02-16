import UIKit

enum RecipeDetailAction {
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
    }
}
