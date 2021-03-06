import Foundation

struct RecipePreview: Decodable {
    let id: Int
    let title: String
    let description: String
}

struct Recipe: Decodable {
    let id: Int
    let title: String
    let description: String
    let author: RecipeAuthor
    let category: RecipeSelectableValue
    let difficulty: RecipeSelectableValue
    let rating: Int
    let preparationTime: Int
    let serving: Int
    let ingredients: [String]
    let steps: [String]
    let publishedDate: String
    let accessCount: Int
    let imageUrl: String
}

struct RecipeAuthor: Decodable {
    let id: Int
    let name: String
}

struct RecipeSelectableValue: Decodable {
    let id: Int
    let name: String
}
