import Foundation

protocol RecipeFormPresenting: AnyObject {
    var viewController: RecipeFormDisplaying? { get set }
    func presentFormFields(_ fields: [RecipeFormField])
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
    func presentFormFields(_ fields: [RecipeFormField]) {
        viewController?.displayFormFields(fields)
    }
    
    func didNextStep(action: RecipeFormAction) {
        coordinator.perform(action: action)
    }
}
