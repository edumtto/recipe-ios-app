import UIKit

struct FormTextFieldEditingViewModel {
    enum FieldDisplayType {
        case shortText
        case longText
        case numeric(description: String)
    }
    let navigationTitle: String
    let fieldDisplayType: FieldDisplayType
    //let fieldType: RecipeFormFieldType
    var fieldValue: String?
    let keyboardType: UIKeyboardType
}
