import Foundation

protocol FormFieldEditingDelegate: AnyObject {
    func didEditField(_ field: RecipeFormField)
}

protocol RecipeFormInteracting: AnyObject {
    func fetchFormSelectableValues()
    func editField(_ field: RecipeFormField)
}

final class RecipeFormInteractor {
    private let service: RecipeFormServicing
    private let presenter: RecipeFormPresenting
    
    private var recipe: EditingRecipe
    private var selectableValues: RecipeFormSelectableValues?

    init(service: RecipeFormServicing, presenter: RecipeFormPresenting, recipe: Recipe?) {
        self.service = service
        self.presenter = presenter
        
        if let recipe = recipe {
            self.recipe = EditingRecipe(recipe: recipe)
        } else {
            self.recipe = EditingRecipe()
        }
    }
}

// MARK: - RecipeFormInteracting
extension RecipeFormInteractor: RecipeFormInteracting {
    func fetchFormSelectableValues() {
        service.fetchRecipeForm { [weak self] result in
            switch result {
            case .success(let formValues):
                self?.selectableValues = formValues
                self?.populateView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func populateView() {
        guard
            let selectableValues = selectableValues,
            selectableValues.categories.count > 0,
            selectableValues.difficulties.count > 0
        else {
            return
        }
        
        let formFields: [RecipeFormField] = [
            .title(recipe.title),
            .description(recipe.description),
            .category(selected: recipe.category, from: selectableValues.categories),
            .difficulty(selected: recipe.difficulty, from: selectableValues.difficulties),
            .serving(recipe.serving),
            .preparationTime(recipe.preparationTime),
            .ingredients(recipe.ingredients),
            .steps(recipe.steps),
            .image(recipe.imageUrl)
        ]
        print("editing recipe")
        presenter.presentFormFields(formFields)
    }

    func editField(_ field: RecipeFormField) {
        presenter.didNextStep(action: .editField(formField: field, didEditDelegate: self))
    }
}

extension RecipeFormInteractor: FormFieldEditingDelegate {
    func didEditField(_ field: RecipeFormField) {
        switch field {
        case let .title(text):
            recipe.title = text
        case let .description(text):
            recipe.description = text
        case let .category(selected, _):
            recipe.category = selected
        case let .difficulty(selected, _):
            recipe.difficulty = selected
        case let .preparationTime(value):
            recipe.preparationTime = value
        case let .serving(value):
            recipe.serving = value
        case let .ingredients(list):
            recipe.ingredients = list
        case let .steps(list):
            recipe.steps = list
        case let .image(url):
            recipe.imageUrl = url
        }
        populateView()
    }
}
