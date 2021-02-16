import UIKit

enum RecipeDetailFactory {
    static func make(id: Int) -> RecipeDetailViewController {
        let service: RecipeDetailServicing = RecipeDetailService()
        let coordinator: RecipeDetailCoordinating = RecipeDetailCoordinator()
        let presenter: RecipeDetailPresenting = RecipeDetailPresenter(coordinator: coordinator)
        let interactor = RecipeDetailInteractor(service: service, presenter: presenter, recipeId: id)
        let viewController = RecipeDetailViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
