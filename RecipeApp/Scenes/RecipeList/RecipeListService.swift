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
                //completion(result)
                
                let mockedResult: [RecipePreview] = [
                    .init(id: 0, title: "Brigadeiro", description: "O brigadeiro é um doce genuinamente brasileiro. Um orgulho só! Essa delícia de chocolate faz a alegria da criançada e de muita gente grande em qualquer circunstância."),
                    .init(id: 1, title: "Bolo comum", description: "Receita de bolo padrão. Prática e fácil de fazer"),
                    .init(id: 2, title: "Pudim de doce de leite", description: "Delicioso pudin com receita tradicional")
                ]
                completion(.success(mockedResult))
            }
        }
    }
}
