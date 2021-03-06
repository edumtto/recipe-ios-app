import UIKit

enum FormTextFieldEditingAction {
    case updateField(RecipeFormField)
}

protocol FormTextFieldEditingCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: FormTextFieldEditingAction)
    var delegate: FormFieldEditingDelegate? { get set }
}

final class FormTextFieldEditingCoordinator {
    weak var viewController: UIViewController?
    weak var delegate: FormFieldEditingDelegate?
}

// MARK: - FormTextFieldEditingCoordinating
extension FormTextFieldEditingCoordinator: FormTextFieldEditingCoordinating {
    func perform(action: FormTextFieldEditingAction) {
        switch action {
        case let .updateField(field):
            delegate?.didEditField(field)
            viewController?.navigationController?.popViewController(animated: true)
        }
    }
}
