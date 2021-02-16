import UIKit

enum RecipeFormFactory {
    static func make(recipe: Recipe? = nil) -> RecipeFormViewController {
        let service: RecipeFormServicing = RecipeFormService()
        let coordinator: RecipeFormCoordinating = RecipeFormCoordinator()
        let presenter: RecipeFormPresenting = RecipeFormPresenter(coordinator: coordinator)
        let interactor = RecipeFormInteractor(service: service, presenter: presenter, recipe: recipe)
        let viewController = RecipeFormViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
