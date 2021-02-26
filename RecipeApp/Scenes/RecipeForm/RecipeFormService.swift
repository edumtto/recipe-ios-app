import Foundation

protocol RecipeFormServicing {
    func fetchRecipeForm(_ completion: @escaping ((Result<RecipeFormSelectableValues, Error>) -> Void))
}

final class RecipeFormService {
}

// MARK: - RecipeFormServicing
extension RecipeFormService: RecipeFormServicing {
    func fetchRecipeForm(_ completion: @escaping ((Result<RecipeFormSelectableValues, Error>) -> Void)) {
        let endpoint = Endpoint(path: "http://localhost:8080/recipes/form", method: .get)
        let api = Api<RecipeFormSelectableValues>(endpoint: endpoint)
        
        api.execute { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
