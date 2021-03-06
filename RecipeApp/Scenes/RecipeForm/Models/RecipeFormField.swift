import Foundation

enum RecipeFormFieldType {
    case shortText
    case longText
    case numeric
    case selectable
    case multiText
}

enum RecipeFormField {
    case title(String?)
    case description(String?)
    case category(selected: RecipeSelectableValue?, from: [RecipeSelectableValue])
    case difficulty(selected: RecipeSelectableValue?, from: [RecipeSelectableValue])
    case preparationTime(Int?)
    case serving(Int?)
    case ingredients([String])
    case steps([String])
    case image(String?)
    
    var name: String {
        switch self {
        case .title:
            return "Título"
        case .description:
            return "Descrição"
        case .category:
            return "Categoria"
        case .difficulty:
            return "Dificuldade"
        case .preparationTime:
            return "Tempo de preparação"
        case .serving:
            return "Serve"
        case .ingredients:
            return "Ingredientes"
        case .steps:
            return "Passos"
        case .image:
            return "Imagem"
        }
    }
    
    var formatedValue: String? {
        switch self {
        case let .title(text), let .description(text):
            return text
        case let .category(selected, _), let .difficulty(selected, _):
            return selected?.name
        case let .preparationTime(value), let .serving(value):
            guard let value = value else { return nil }
            return String(value)
        case let .ingredients(list), let .steps(list):
            return list.joined(separator: ", ")
        case let .image(url):
            return url
        }
    }
    
    var type: RecipeFormFieldType {
        switch self {
        case .title:
            return .shortText
        case .description:
            return .longText
        case .category:
            return .selectable
        case .difficulty:
            return .selectable
        case .preparationTime:
            return .numeric
        case .serving:
            return .numeric
        case .ingredients:
            return .multiText
        case .steps:
            return .multiText
        case .image:
            return .shortText
        }
    }
}
