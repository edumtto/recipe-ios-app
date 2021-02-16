import Foundation

protocol RecipeListPresenting: AnyObject {
    var viewController: RecipeListDisplaying? { get set }
    func present(recipes: [RecipePreview])
    func present(error: Error)
    func didNextStep(action: RecipeListAction)
}

final class RecipeListPresenter {
    private let coordinator: RecipeListCoordinating
    weak var viewController: RecipeListDisplaying?

    init(coordinator: RecipeListCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - RecipeListPresenting
extension RecipeListPresenter: RecipeListPresenting {
    func present(recipes: [RecipePreview]) {
        viewController?.display(recipes: recipes)
    }
    
    func present(error: Error) {
        viewController?.display(errorTitle: "Erro!", message: error.localizedDescription)
    }
    
    func didNextStep(action: RecipeListAction) {
        coordinator.perform(action: action)
    }
}
