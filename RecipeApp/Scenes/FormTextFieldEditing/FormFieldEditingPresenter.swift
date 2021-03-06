import Foundation

protocol FormTextFieldEditingPresenting: AnyObject {
    var viewController: FormTextFieldEditingDisplaying? { get set }
    func presentShortTextField(_ formField: RecipeFormField)
    func presentLongTextField(_ formField: RecipeFormField)
    func didNextStep(action: FormTextFieldEditingAction)
}

final class FormTextFieldEditingPresenter {
    private let coordinator: FormTextFieldEditingCoordinating
    weak var viewController: FormTextFieldEditingDisplaying?

    init(coordinator: FormTextFieldEditingCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - FormTextFieldEditingPresenting
extension FormTextFieldEditingPresenter: FormTextFieldEditingPresenting {
    func presentShortTextField(_ formField: RecipeFormField) {
        switch formField {
        case .title(let title):
            let viewModel = FormTextFieldEditingViewModel(
                navigationTitle: formField.name,
                fieldDisplayType: .shortText,
                fieldValue: title,
                keyboardType: .default
            )
            viewController?.displayEditingField(viewModel: viewModel)
            
        case .description(let description):
            let viewModel = FormTextFieldEditingViewModel(
                navigationTitle: formField.name,
                fieldDisplayType: .longText,
                fieldValue: description,
                keyboardType: .default
            )
            viewController?.displayEditingField(viewModel: viewModel)
            
        default:
            break
        }
    }
    
    func presentLongTextField(_ formField: RecipeFormField) {
    }
    
    func didNextStep(action: FormTextFieldEditingAction) {
        coordinator.perform(action: action)
    }
}
