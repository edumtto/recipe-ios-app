import UIKit

enum RecipeFormAction {
    case editField(formField: RecipeFormField, didEditDelegate: FormFieldEditingDelegate)
}

protocol RecipeFormCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: RecipeFormAction)
}

final class RecipeFormCoordinator {
    weak var viewController: UIViewController?
}

// MARK: - RecipeFormCoordinating
extension RecipeFormCoordinator: RecipeFormCoordinating {
    func perform(action: RecipeFormAction) {
        switch action {
        case let .editField(formField, didEditDelegate):
            let editingController = FormTextFieldEditingFactory.make(formField: formField, didEditDelegate: didEditDelegate)
            viewController?.navigationController?.pushViewController(editingController, animated: true)
        }
    }
}
