import Foundation

protocol RecipeDetailPresenting: AnyObject {
    var viewController: RecipeDetailDisplaying? { get set }
    func present(recipe: Recipe)
    func present(error: Error)
    func didNextStep(action: RecipeDetailAction)
}

final class RecipeDetailPresenter {
    private let coordinator: RecipeDetailCoordinating
    weak var viewController: RecipeDetailDisplaying?

    init(coordinator: RecipeDetailCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - RecipeDetailPresenting
extension RecipeDetailPresenter: RecipeDetailPresenting {
    func present(recipe: Recipe) {
        viewController?.display(recipe: recipe)
    }
    
    func present(error: Error) {
        viewController?.display(errorTitle: "Erro!", message: error.localizedDescription)
    }
    
    func didNextStep(action: RecipeDetailAction) {
        coordinator.perform(action: action)
    }
}
