import Foundation

struct EditingRecipe: Decodable {
    let id: Int?
    var title: String?
    var description: String?
    let author: RecipeAuthor?
    var category: RecipeSelectableValue?
    var difficulty: RecipeSelectableValue?
    let rating: Int
    var preparationTime: Int?
    var serving: Int?
    var ingredients: [String]
    var steps: [String]
    let publishedDate: String?
    let accessCount: Int
    var imageUrl: String?
    
    init(recipe: Recipe) {
        id = recipe.id
        title = recipe.title
        description = recipe.description
        author = recipe.author
        category = recipe.category
        difficulty = recipe.difficulty
        rating = recipe.rating
        preparationTime = recipe.preparationTime
        serving = recipe.serving
        ingredients = recipe.ingredients
        steps = recipe.steps
        publishedDate = recipe.publishedDate
        accessCount = recipe.accessCount
        imageUrl = recipe.imageUrl
    }
    
    init() {
        id = nil
        title = nil
        description = nil
        author = nil
        category = nil
        difficulty = nil
        rating = 0
        preparationTime = nil
        serving = nil
        ingredients = []
        steps = []
        publishedDate = nil
        accessCount = 0
        imageUrl = nil
    }
}
