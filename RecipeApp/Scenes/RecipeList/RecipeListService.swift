import Foundation

protocol RecipeListServicing {
    func fetchRecipeList(_ completion: @escaping ((Result<[RecipePreview], Error>) -> Void))
}

final class RecipeListService {
}

// MARK: - RecipeListServicing
extension RecipeListService: RecipeListServicing {
    func fetchRecipeList(_ completion: @escaping ((Result<[RecipePreview], Error>) -> Void)) {
        let endpoint = Endpoint(path: "http://localhost:8080/recipes/", method: .get)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let api = Api<[RecipePreview]>(endpoint: endpoint, decoder: decoder)
        
        api.execute { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
