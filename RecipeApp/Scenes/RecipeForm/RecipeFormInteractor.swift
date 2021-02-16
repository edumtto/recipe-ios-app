import Foundation

protocol RecipeFormInteracting: AnyObject {
    func populateView()
    func set(category: RecipeCategory)
}

final class RecipeFormInteractor {
    private let service: RecipeFormServicing
    private let presenter: RecipeFormPresenting
    
    private let recipe: Recipe?

    init(service: RecipeFormServicing, presenter: RecipeFormPresenting, recipe: Recipe?) {
        self.service = service
        self.presenter = presenter
        self.recipe = recipe
    }
}

// MARK: - RecipeFormInteracting
extension RecipeFormInteractor: RecipeFormInteracting {
    func populateView() {
        
        if let recipe = recipe {
            print("editing recipe")
        } else {
            print("adding new recipe")
        }
        presenter.displaySomething()
    }
    
    func set(category: RecipeCategory) {
        //recipe?.Category = category
    }
}
