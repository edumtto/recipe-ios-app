import UIKit

enum FormTextFieldEditingFactory {
    static func make(formField: RecipeFormField, didEditDelegate: FormFieldEditingDelegate) -> FormTextFieldEditingViewController {
        let service: FormTextFieldEditingServicing = FormTextFieldEditingService()
        let coordinator: FormTextFieldEditingCoordinating = FormTextFieldEditingCoordinator()
        let presenter: FormTextFieldEditingPresenting = FormTextFieldEditingPresenter(coordinator: coordinator)
        let interactor = FormTextFieldEditingInteractor(service: service, presenter: presenter, formField: formField)
        let viewController = FormTextFieldEditingViewController(interactor: interactor)

        coordinator.delegate = didEditDelegate
        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
