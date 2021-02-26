import Foundation

struct RecipeFormField {
    enum FieldType: String {
        case title = "Título"
        case description = "Descrição"
        case category = "Categoria"
        case difficulty = "Dificuldade"
        case preparationTime = "Tempo de preparação"
        case serving = "Serve"
        case ingredients = "Ingredientes"
        case steps = "Passos"
        case image = "Imagem"
    }
    
    let type: FieldType
    let value: String?
}
