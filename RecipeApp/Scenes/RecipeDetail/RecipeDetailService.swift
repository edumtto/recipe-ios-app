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
                //completion(result)
                
                let mockedResult: Recipe =
                    .init(
                        id: 0,
                        title: "Brigadeiro",
                        description: "O brigadeiro é um doce genuinamente brasileiro. Um orgulho só! Essa delícia de chocolate faz a alegria da criançada e de muita gente grande em qualquer circunstância.",
                        author: .init(id: 0, name: "Eduardo"),
                        category: .init(id: 1, name: "Doces e sobremesas"),
                        difficulty: .init(id: 0, name: "Fácil"),
                        rating: 5,
                        preparationTime: 50,
                        serving: 20,
                        ingredients: [
                            "1 caixa de leite condensado",
                            "1 colher (sopa) de margarina sem sal",
                            "7 colheres (sopa) de achocolatado ou 4 colheres (sopa) de chocolate em pó",
                            "chocolate granulado"],
                        steps: ["Em uma panela funda, acrescente o leite condensado, a margarina e o chocolate em pó.",
                                "Cozinhe em fogo médio e mexa até que o brigadeiro comece a desgrudar da panela.",
                                "Deixe esfriar e faça pequenas bolas com a mão passando a massa no chocolate granulado."],
                        publishedDate: "",
                        accessCount: 42,
                        imageUrl: "https://cdn.panelinha.com.br/receita/958014000000-Brigadeiro.jpg")
                completion(.success(mockedResult))
            }
        }
    }
}
