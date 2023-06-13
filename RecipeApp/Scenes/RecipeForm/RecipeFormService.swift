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
                //completion(result)
                
                let mockedResult = RecipeFormSelectableValues(
                    categories: [
                        .init(id: 0, name: "Entradas"),
                        .init(id: 1, name: "Sopas e caldos"),
                        .init(id: 2, name: "Saladas"),
                        .init(id: 3, name: "Pães e bolos"),
                        .init(id: 4, name: "Doces e sobremesas"),
                        .init(id: 5, name: "Diversos")
                    ],
                    difficulties: [
                        .init(id: 0, name: "Fácil"),
                        .init(id: 1, name: "Moderado"),
                        .init(id: 2, name: "Difícil")
                    ]
                )
                completion(.success(mockedResult))
            }
        }
    }
}
