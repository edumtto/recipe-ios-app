import Foundation

struct RecipeFormSelectableValues: Decodable {
    let categories: [RecipeCategory]
    let dificulties: [RecipeDifficulty]
}
