import Foundation

protocol RecipeDetailInteracting: AnyObject {
    func fetchRecipe()
}

final class RecipeDetailInteractor {
    private let service: RecipeDetailServicing
    private let presenter: RecipeDetailPresenting
    
    private let recipeId: Int

    init(service: RecipeDetailServicing, presenter: RecipeDetailPresenting, recipeId: Int) {
        self.service = service
        self.presenter = presenter
        self.recipeId = recipeId
    }
}

// MARK: - RecipeDetailInteracting
extension RecipeDetailInteractor: RecipeDetailInteracting {
    func fetchRecipe() {
        service.fetchRecipeDetail(id: recipeId) { [weak self] result in
            switch result {
            case .success(let recipe):
                self?.presenter.present(recipe: recipe)
            case .failure(let error):
                self?.presenter.present(error: error)
            }
        }
    }
}
