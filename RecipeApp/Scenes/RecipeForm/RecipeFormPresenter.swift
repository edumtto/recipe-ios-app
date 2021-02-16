import Foundation

protocol RecipeFormPresenting: AnyObject {
    var viewController: RecipeFormDisplaying? { get set }
    func displaySomething()
    func didNextStep(action: RecipeFormAction)
}

final class RecipeFormPresenter {
    private let coordinator: RecipeFormCoordinating
    weak var viewController: RecipeFormDisplaying?

    init(coordinator: RecipeFormCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - RecipeFormPresenting
extension RecipeFormPresenter: RecipeFormPresenting {
    func displaySomething() {
        viewController?.displaySomething()
    }
    
    func didNextStep(action: RecipeFormAction) {
        coordinator.perform(action: action)
    }
}
