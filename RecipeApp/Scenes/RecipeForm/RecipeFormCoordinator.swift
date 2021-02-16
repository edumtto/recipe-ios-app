import UIKit

enum RecipeFormAction {
}

protocol RecipeFormCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: RecipeFormAction)
}

final class RecipeFormCoordinator {
    weak var viewController: UIViewController?
}

// MARK: - RecipeFormCoordinating
extension RecipeFormCoordinator: RecipeFormCoordinating {
    func perform(action: RecipeFormAction) {
    }
}
