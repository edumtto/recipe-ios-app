import UIKit

enum RecipeListFactory {
    static func make() -> RecipeListViewController {
        let service: RecipeListServicing = RecipeListService()
        let coordinator: RecipeListCoordinating = RecipeListCoordinator()
        let presenter: RecipeListPresenting = RecipeListPresenter(coordinator: coordinator)
        let interactor = RecipeListInteractor(service: service, presenter: presenter)
        let viewController = RecipeListViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
