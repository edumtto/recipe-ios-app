import Foundation

protocol RecipeListInteracting: AnyObject {
    func fetchRecipeList()
    func openRecipeDescription(id: Int)
    func openAddRecipeForm()
}

final class RecipeListInteractor {
    private let service: RecipeListServicing
    private let presenter: RecipeListPresenting

    init(service: RecipeListServicing, presenter: RecipeListPresenting) {
        self.service = service
        self.presenter = presenter
    }
}

// MARK: - RecipeListInteracting
extension RecipeListInteractor: RecipeListInteracting {
    func fetchRecipeList() {
        service.fetchRecipeList { [weak self] result in
            switch result {
            case .success(let recipes):
                self?.presenter.present(recipes: recipes)
            case .failure(let error):
                self?.presenter.present(error: error)
            }
        }
        //presenter.displaySomething()
    }
    
    func openRecipeDescription(id: Int) {
        presenter.didNextStep(action: .recipeDetail(id: id))
    }
    
    func openAddRecipeForm() {
        presenter.didNextStep(action: .addRecipeForm)
    }
}
