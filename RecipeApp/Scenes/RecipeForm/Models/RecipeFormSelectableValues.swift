import Foundation

struct RecipeFormSelectableValues: Decodable {
    let categories: [RecipeSelectableValue]
    let difficulties: [RecipeSelectableValue]
    
    private enum CodingKeys : String, CodingKey {
        case categories = "Categories"
        case difficulties = "Difficulties"
    }
}
