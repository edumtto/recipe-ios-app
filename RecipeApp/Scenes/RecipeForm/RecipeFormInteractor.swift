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
        let formFields: [RecipeFormField]
        if let recipe = recipe {
            formFields = [
                RecipeFormField(type: .title, value: recipe.title),
                RecipeFormField(type: .description, value: recipe.description),
                RecipeFormField(type: .category, value: recipe.category.name),
                RecipeFormField(type: .difficulty, value: recipe.difficulty.name),
                RecipeFormField(type: .serving, value: String(recipe.serving) + " porções"),
                RecipeFormField(type: .preparationTime, value: String(recipe.preparationTime) + " minutos"),
                RecipeFormField(type: .ingredients, value: recipe.ingredients.joined(separator: ", ")),
                RecipeFormField(type: .steps, value: recipe.steps.joined(separator: ", ")),
                RecipeFormField(type: .image, value: recipe.imageUrl)
            ]
            print("editing recipe")
        } else {
            formFields = [
                RecipeFormField(type: .title, value: nil),
                RecipeFormField(type: .description, value: nil),
                RecipeFormField(type: .category, value: nil),
                RecipeFormField(type: .difficulty, value: nil),
                RecipeFormField(type: .serving, value: nil),
                RecipeFormField(type: .preparationTime, value: nil),
                RecipeFormField(type: .ingredients, value: nil),
                RecipeFormField(type: .steps, value: nil),
                RecipeFormField(type: .image, value: nil)
            ]
            print("adding new recipe")
        }
        presenter.presentFormFields(formFields)
    }
    
    func set(category: RecipeCategory) {
        //recipe?.Category = category
    }
}
