import Foundation

protocol FormTextFieldEditingInteracting: AnyObject {
    func configureView()
    func didConfirm(value: String?)
}

final class FormTextFieldEditingInteractor {
    private let service: FormTextFieldEditingServicing
    private let presenter: FormTextFieldEditingPresenting
    private var formField: RecipeFormField

    init(service: FormTextFieldEditingServicing, presenter: FormTextFieldEditingPresenting, formField: RecipeFormField) {
        self.service = service
        self.presenter = presenter
        self.formField = formField
    }
}

// MARK: - FormTextFieldEditingInteracting
extension FormTextFieldEditingInteractor: FormTextFieldEditingInteracting {
    func configureView() {
        presenter.presentTextField(formField)
    }
    
    func didConfirm(value: String?) {
        switch formField {
        case .title:
            let newFormField = RecipeFormField.title(value ?? "")
            presenter.didNextStep(action: .updateField(newFormField))
            
        case .description:
            let newFormField = RecipeFormField.description(value ?? "")
            presenter.didNextStep(action: .updateField(newFormField))
            
        default:
            break
        }
    }
}
