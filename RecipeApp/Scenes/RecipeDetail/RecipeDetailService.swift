import Foundation

protocol RecipeDetailServicing {
    func fetchRecipeDetail(id: Int, _ completion: @escaping ((Result<Recipe, Error>) -> Void))
}

final class RecipeDetailService {
}

// MARK: - RecipeDetailServicing
extension RecipeDetailService: RecipeDetailServicing {
    func fetchRecipeDetail(id: Int, _ completion: @escaping ((Result<Recipe, Error>) -> Void)) {
        let endpoint = Endpoint(path: "http://localhost:8080/recipes/" + String(id), method: .get)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let api = Api<Recipe>(endpoint: endpoint, decoder: decoder)
        
        api.execute { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
